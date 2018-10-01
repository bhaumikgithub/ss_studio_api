class PhotosController < ApplicationController
  include InheritAction
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :mark_as_checked ]
  before_action :fetch_active_watermark,:watermark_processor,only: [:create]
  before_action :fetch_photo, only: [:set_cover_photo]

  # GET /photos
  def index
    @photos = Photo.all
    json_response({ success: true , data: {photos: @photos} }, 200)
  end

  # POST /photos
  def create
    @photos = Photo.create!(photo_params)
    if @photos.present? && !current_resource_owner.profile_completeness.photo
      next_task = next_task('photo')
      current_resource_owner.profile_completeness.update(photo: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    json_response({
      success: true,
      data: {
        photos: array_serializer.new(@photos, serializer: Photos::CreatePhotoAttributesSerializer),
      }
    }, 201)
  end

  # DELETE /photos/multi_delete
  def multi_delete
    if params['photo']['ids'].present?
      Photo.where("id IN (?)",params[:photo][:ids]).destroy_all
    else
      json_response({success: false, message: 'Please select atleast one photo.'}, 400) and return
    end
    json_response({success: true, message: "Selected photos deleted successfully."}, 200)
  end

  # PATCH /photos/:id/set_cover_photo
  def set_cover_photo
    @photo.set_as_cover
    json_response({
      success: true,
      message: "Set as cover photo successfully.",
      data: {
        photo: single_record_serializer.new(@photo, serializer: Photos::SetCoverPhotoAttributesSerializer),
      }
    }, 201)
  end

  # PUT /photos/mark_as_checked
  def mark_as_checked
    @photos = Photo.where("id IN (?)",params[:photo][:ids])
    if @photos.length > 0
      if @photos.first.is_selected == false
        @photos.update_all(is_selected: true)
      else
        @photos.update_all(is_selected: false)
      end
    end
    @photos = Photo.where("id IN (?)",params[:photo][:ids])
    render_success_response({ photos: array_serializer.new(@photos, serializer: Photos::SetCoverPhotoAttributesSerializer) }, 201)
  end

  private

  def fetch_album
    @album = Album.find(params[:album_id])
  end

  def photo_params
    params.require(:photo).map do |p|
      ActionController::Parameters.new(p).permit(:image, :photo_title, :status, :user_id, :imageable_id, :imageable_type, :is_cover_photo).merge(:user_id => current_resource_owner.id)
    end 
  end

  def fetch_photo
    @photo = Photo.find(params[:id])
  end

  # Finding active watermark for logged in user.
  def fetch_active_watermark
    if current_resource_owner.watermarks.present? && current_resource_owner.watermarks.find_by(status: "active") != nil
      if current_resource_owner.watermarks.present?
        Photo.watermark_url = current_resource_owner.watermarks.find_by(status: "active").photo.image.path
        Photo.watermark_thumb_url = current_resource_owner.watermarks.find_by(status: "active").photo.image.path(:thumb)
        Photo.watermark_medium_url = current_resource_owner.watermarks.find_by(status: "active").photo.image.path(:medium)
      else
        Photo.watermark_url = "#{Rails.root}/public/watermark.png"
      end 
    end
  end

  # Decide whether to apply watermark or not.
  def watermark_processor
    if current_resource_owner.watermarks.present? && current_resource_owner.watermarks.find_by(status: "active") != nil
      if params[:photo][0][:imageable_type] == "Album"
        Photo.apply_watermark = true
      else
        Photo.apply_watermark = false
      end
    else
      Photo.apply_watermark = false
    end
  end
end