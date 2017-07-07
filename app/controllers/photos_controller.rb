class PhotosController < ApplicationController
  include InheritAction
  before_action :fetch_album, only: [:create, :multi_delete, :set_cover_photo, :index]

  # GET /albums/:album_id/photos 
  def index
    @photos = @album.photos
    json_response({ success: true , data: {photos: @photos} }, 200)
  end

  # POST /albums/:album_id/photos
  def create
    @photos = @album.photos.create(photo_params)
    render_success_response({ :photos => @photos}, 201)
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
      ActionController::Parameters.new(p).permit(:image, :photo_title, :album_id, :status, :added_by).merge(:added_by => current_resource_owner.id)
    end 
  end

end