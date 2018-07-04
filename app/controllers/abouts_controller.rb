class AboutsController < ApplicationController
	skip_before_action :doorkeeper_authorize!, only: [ :about_us_detail ]
	before_action :fetch_about_us_detail, only: [ :show, :update ]

  #  GET  /abouts
  def show
    if @about_us_detail
      json_response({
        success: true,
        data: {
          about_us: single_record_serializer.new(@about_us_detail, serializer: Abouts::AboutAttributesSerializer),
        }
      }, 200)
    end
  end

  def create
    @about = current_resource_owner.create_about(about_us_params)
    @about.update_attributes!(facebook_link: '', twitter_link: '',instagram_link: '', youtube_link: '',vimeo_link: '', linkedin_link: '',pinterest_link:'',flickr_link:'') if @about
    json_response({
      success: true,
      data: {
        about_us: single_record_serializer.new(@about, serializer: Abouts::AboutAttributesSerializer),
      }
    }, 201)
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

  # GET  /about_us
  def about_us_detail
    about_us_detail = User.get_user(params[:user]).about
    json_response({
      success: true,
      data: {
        about_us: single_record_serializer.new(about_us_detail, serializer: Abouts::AboutAttributesSerializer),
      }
    }, 200)
  end

  private

  def about_us_params
    params.require(:about).permit(:title_text, :description, :facebook_link, :twitter_link, :instagram_link, :youtube_link, :vimeo_link,:linkedin_link, :pinterest_link, :flickr_link, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id])
  end

  def fetch_about_us_detail
    @about_us_detail = current_resource_owner&.about
  end
end
