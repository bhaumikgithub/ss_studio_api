class PhotosController < ApplicationController
  include InheritAction
  # before_action :fetch_album, only: [:multi_delete, :set_cover_photo, :index]
    before_action :fetch_active_watermark,:watermark_processor,only: [:create]

  # GET /photos 
  def index
    @photos = Photo.all
    json_response({ success: true , data: {photos: @photos} }, 200)
  end

  # POST /photos
  def create
    @photos = Photo.create!(photo_params)
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
    @photo = Photo.find(params[:id])
    @photo.set_as_cover
    json_response({
      success: true,
      message: "Set as cover photo successfully.",
      data: {
        photos: single_record_serializer.new(@photo, serializer: Photos::SetCoverPhotoAttributesSerializer),
      }
    }, 201)
  end

  private

  def fetch_album
    @album = Album.find(params[:album_id])
  end

  def photo_params
    params.require(:photo).map do |p|
      ActionController::Parameters.new(p).permit(:image, :photo_title, :status, :user_id, :imageable_id, :imageable_type).merge(:user_id => current_resource_owner.id)
    end 
  end

  # Finding active watermark for logged in user.
  def fetch_active_watermark
    if current_resource_owner.watermarks.present?
      Photo.watermark_url = current_resource_owner.watermarks.find_by(status: "active").photo.image.path
    else
      Photo.watermark_url = "#{Rails.root}/public/watermark.png"
    end 
  end

  # Decide whether to apply watermark or not.
  def watermark_processor
    if params[:photo][0][:imageable_type] == "Album"
      Photo.apply_watermark = true
    else
      Photo.apply_watermark = false
    end
  end
end