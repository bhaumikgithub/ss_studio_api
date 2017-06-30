class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :doorkeeper_authorize!
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.find_by(email: resource_params[:email] )

    if resource
      resource.send_reset_password_instructions
    else
      render json: { error: "Couldn't find #{resource_name.to_s.capitalize} with 'email'=#{resource_params[:email]} and 'subdomain'=#{resource_params[:subdomain]}" }, status: 400 and return
    end
    yield resource if block_given?

    if successfully_sent?(resource)
      render_success_response({ message: "Reset link sent on email: #{resource_params[:email]}" }, 200)
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        bypass_sign_in(resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      render_success_response({ :users => resource }, 200)
      # render json: resource, status: :ok
    else
      set_minimum_password_length
      render json: {error: resource.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
