class PhotosController < ApplicationController
  include InheritAction
  before_action :fetch_album, only: [:create, :multi_delete, :set_cover_photo, :index]
  before_action :fetch_watermark_active, only: [:create]

  # GET /albums/:album_id/photos 
  def index
    @photos = @album.photos
    json_response({ success: true , data: {photos: @photos} }, 200)
  end

  # POST /albums/:album_id/photos
  def create
    binding.pry
    @photos = Photo.create(photo_params)
    if @photos.save!
      render_success_response({ :photos => @photos}, 201)
    end
  end

  # DELETE /albums/:album_id/photos/multi_delete
  def multi_delete
    unless @album.photos.present?
      json_response({success: false, message: "Photos not found"}, 400)
    end

    if params['photo']['id'].present?
      @album.photos.where("id IN (?)",params[:photo][:id]).destroy_all
    else
      @album.photos.destroy_all
    end
    json_response({success: true, message: "Selected photos deleted successfully."}, 200)
  end

  # PATCH /albums/:album_id/photos/:id/set_cover_photo
  def set_cover_photo
    @photo = @album.photos.find(params[:id])
    @photo.set_as_cover
    json_response({success: true, message: "Set as cover photo successfully.", data: {albums: @photo}}, 200)
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

  # fetch current user's active watermark
  def fetch_watermark_active
    Photo.watermark_url = current_resource_owner.watermarks.where(status: "active").first.watermark_image.path
  end

end