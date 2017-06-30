class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :doorkeeper_authorize!


  def confirm
    if params[resource_name].present? && params[resource_name][:confirmation_token].present?
      self.resource = resource_class.find_by(confirmation_token: params[resource_name][:confirmation_token])
      if self.resource.present?
        resource.password = params[resource_name][:password]
        resource.password_confirmation = params[resource_name][:password_confirmation]
        if resource.password_match? && resource.valid?
          resource.update_attributes!(permitted_params)
          resource.active_user
          resource.confirm
          raw_confirmation_token, db_confirmation_token = Devise.token_generator.generate(resource.class, :confirmation_token)
          resource.update_attributes!(confirmation_token: db_confirmation_token)
          UserMailer.user_confirmation(resource).deliver_now
          # render json: resource, status: :ok
          render_success_response({ :users => resource }, 200)
        else
         render json: {error: resource.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json: { error: "Confirmation token is invalid or expired." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Please supply valid parameters." }, status: 400
    end
  end
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
