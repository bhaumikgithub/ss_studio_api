class Users::ConfirmationsController < Devise::ConfirmationsController
	skip_before_action :doorkeeper_authorize!

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      redirect_to  ENV['FRONT_URL']+'admin'
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end
end