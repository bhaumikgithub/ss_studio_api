class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :doorkeeper_authorize!

   def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      if resource.errors.any?
        render_unprocessable_entity_response(resource)
      end
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      if Devise.sign_in_after_reset_password
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      render_unprocessable_entity_response(resource)
    end
  end
end
