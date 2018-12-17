class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!

  # POST /resource
  def create
    User.captcha = params[:user][:captcha]
    User.created_by = params[:user][:created_by]
    User.is_validate = true
    begin
      build_resource(sign_up_params)
      if resource.save!
        if resource.persisted?
          if resource.active_for_authentication?
            sign_up(resource_name, resource)
          else
            expire_data_after_sign_in!
          end
          update_subscription_package
          render_success_response({ :users => resource }, 200)
        else
          render_unprocessable_entity_response(resource)
        end
      else
        render_unprocessable_entity_response(resource)
      end
    rescue ActiveRecord::RecordNotUnique
      resource.errors.add('email', 'has already been taken')
      render_unprocessable_entity_response(resource)
    end
  end

  # patch /resource
  def update
    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      render_success_response({ :users => resource }, 200)
    else
      render_unprocessable_entity_response(resource)
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    head 200
  end

  def update_subscription_package
    binding.pry
    if resource.package_users.present? && params[:user][:package_id].present?
      resource.package_users.update(package_status: 1)
      package = Package.find_by_id(params[:user][:package_id])
      plan_start_date = Date.today
      dur_time = package.duration.split()
      total_day = dur_time != "" ? dur_time[0].to_i : 0
      if package.duration.include?('Days') ||  package.duration.include?('Day')
        plan_end_date = plan_start_date + total_day.days
      elsif package.duration.include?('Month') ||  package.duration.include?('Months')
        plan_end_date = plan_start_date + total_day.months
      elsif package.duration.include?('Year') ||  package.duration.include?('Years')
        plan_end_date = plan_start_date + total_day.years
      else
        plan_end_date = plan_start_date + 1.years
      end
      resource.package_users.create(package_id: package.id, package_start_date: plan_start_date, package_end_date: plan_end_date, package_status: 0)
      resource.package_users.find_by(package_status: 'active').present? ? resource.update(status: 2) : resource.update(status: 3)
    end
  end
  protected

  def authenticate_scope!
    self.resource = User.find(params[:id])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
