class UserLogosController < ApplicationController
	skip_before_action :doorkeeper_authorize!, only: [ :get_logo ]
	include InheritAction

	# Post /users/:id/user_logos
	def create
		Photo.apply_watermark = false
		@user_logo = current_resource_owner.create_user_logo(resource_params)
		json_response({
      success: true,
      data: {
        user_logo: single_record_serializer.new(@user_logo, serializer: UserLogos::UserLogoAttributesSerializer),
      }
    }, 201)
	end

	# PUT /users/:id/user_logos/:id
  def update
    @userlogo = UserLogo.find_by(id: params[:id])
    @userlogo.photo.apply_watermark = false
    @userlogo.update(resource_params)
    json_response({
      success: true,
      data: {
        user_logo: single_record_serializer.new(@userlogo, serializer: UserLogos::UserLogoAttributesSerializer),
      }
    }, 201)
  end

  # GET /get_logo
  def get_logo
  	@user_logo = User.get_user(params[:user]).user_logo
  	json_response({
      success: true,
      data: {
        user_logo: single_record_serializer.new(@user_logo, serializer: UserLogos::UserLogoAttributesSerializer),
      }
    }, 200)
  end

  private

  def resource_params
    params.require(:user_logo).permit(:user_id,photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id])
  end

end
