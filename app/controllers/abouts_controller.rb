class AboutsController < ApplicationController
	skip_before_action :doorkeeper_authorize!, only: [ :show ]
	before_action :fetch_about_us_detail, only: [ :show, :update ]

  #  GET  /abouts
  def show
  	json_response({
      success: true,
      data: {
        about_us: single_record_serializer.new(@about_us_detail, serializer: Abouts::AboutAttributesSerializer),
      }
    }, 200)
  end

  # PUT    /abouts
  def update
    @about_us_detail.update_attributes!(about_us_params)
    json_response({
      success: true,
      data: {
        about_us: single_record_serializer.new(@about_us_detail, serializer: Abouts::AboutAttributesSerializer),
      }
    }, 201)
  end

  private

  def about_us_params
    params.require(:about).permit(:title_text, :description, :facebook_link, :twitter_link, :instagram_link, :youtube_link, :vimeo_link,:linkedin_link, :pinterest_link, :flickr_link, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id])
  end

  def fetch_about_us_detail
    @about_us_detail = About.first
  end
end
