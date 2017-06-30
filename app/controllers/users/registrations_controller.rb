class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :doorkeeper_authorize!



  # POST /resource
  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
        else
          expire_data_after_sign_in!
        end
        UserMailer.confirmation_instructions(resource, resource.confirmation_token).deliver_now
        render_success_response({ :users => resource }, 200)
        # render json: resource, status: :ok
      else
        # render_success_response({ :"#{resource_name_plural}" => resource }, status: :unprocessable_entity)
        render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
      end
    else
      # render_success_response({ :"#{resource_name_plural}" => resource }, status: :unprocessable_entity)
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
    
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # patch /resource
  def update
    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      render_success_response({ :users => resource }, 200)
      # render json: resource, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy

    head 200
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  protected

  def authenticate_scope!
    # send(:"authenticate_#{resource_name}!", force: true)
     self.resource = User.find(params[:id])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
