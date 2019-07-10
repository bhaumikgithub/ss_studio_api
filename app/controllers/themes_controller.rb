class ThemesController < ApplicationController
	before_action :fetch_theme_detail, only: [ :show, :update ]

	#  GET /themes
  def show
    if @theme_detail
      json_response({
        success: true,
        data: {
          theme: single_record_serializer.new(@theme_detail, serializer: Themes::ThemeAttributesSerializer),
        }
      }, 200)
    else
    	json_response({success: false, message: "Enter Valid Passcode.", errors: 'Invalid Passcode' }, 401)
    end
  end

  # PUT /themes
  def update
  	if @theme_detail.nil?
  		@theme_detail = current_resource_owner.create_theme(theme_params)
  	else
	  	@theme_detail.update_attributes!(theme_params)
	  end
  	json_response({
      success: true,
      data: {
        theme: single_record_serializer.new(@theme_detail, serializer: Themes::ThemeAttributesSerializer),
      }
    }, 201)
  end

	private

  def theme_params
    params.require(:theme).permit!
  end

  def fetch_theme_detail
    @theme_detail = current_resource_owner&.theme
  end
end
