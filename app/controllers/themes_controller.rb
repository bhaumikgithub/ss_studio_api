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
    elsif params[:resetTheme]
      @theme_detail.update_attributes!(header_links: {}, normal_links: {}, footer_links: {}, title_color: {}, normal_text_color: {}, header_background: {}, body_background: {}, footer_background: {}, bullet_icon_color: {}, image_overlay_font_color: {}, header_title_color: {}, hover_header_link: {}, active_header_link: {}, hover_normal_link: {}, active_normal_link: {})
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
