class AboutsController < ApplicationController
  include ProfileCompleteHelper
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
    Photo.is_watermark = true
    Photo.is_logo = true
    @about = current_resource_owner.create_about(about_us_params)
    @about.update_attributes!(facebook_link: '', twitter_link: '',instagram_link: '', youtube_link: '',vimeo_link: '', linkedin_link: '',pinterest_link:'',flickr_link:'', google_link: '') if @about
    Photo.is_logo = false
    Photo.is_watermark = false
    json_response({
      success: true,
      data: {
        about_us: single_record_serializer.new(@about, serializer: Abouts::AboutAttributesSerializer),
      }
    }, 201)
  end

  # PUT    /abouts
  def update
    Photo.is_watermark = true
    Photo.is_logo = true
    @about_us_detail.update_attributes!(about_us_params)
    if @about_us_detail.present? && !current_resource_owner.profile_completeness.about_us
      next_task = next_task('about_us')
      current_resource_owner.profile_completeness.update(about_us: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    elsif @about_us_detail.social_links.values.reject { |c| c.empty? }.present? && !current_resource_owner.profile_completeness.social_media_link
      next_task = next_task('social_media_link')
      current_resource_owner.profile_completeness.update(social_media_link: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    Photo.is_logo = false
    Photo.is_watermark = false
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
    if about_us_detail
      json_response({
        success: true,
        data: {
          about_us: single_record_serializer.new(about_us_detail, serializer: Abouts::AboutAttributesSerializer),
        }
      }, 200)
    end
  end

  private

  def about_us_params
    params.require(:about).permit(:title_text, :description, :facebook_link, :twitter_link, :instagram_link, :youtube_link, :vimeo_link,:linkedin_link, :pinterest_link, :flickr_link, :google_link, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id])
  end

  def fetch_about_us_detail
    @about_us_detail = current_resource_owner&.about
  end
end
