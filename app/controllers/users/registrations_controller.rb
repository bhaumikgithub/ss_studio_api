class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!

  # POST /resource
  def create
    User.captcha = params[:user][:captcha]
    User.is_validate = true
    build_resource(sign_up_params)
    if resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
        else
          expire_data_after_sign_in!
        end
        render_success_response({ :users => resource }, 200)
      else
        render_unprocessable_entity_response(resource)
      end
    else
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

  protected

  def authenticate_scope!
    self.resource = User.find(params[:id])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
