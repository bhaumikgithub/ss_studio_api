class PhotosController < ApplicationController
  include InheritAction

  def create
    @album = Album.find(params[:album_id])
    @photos = @album.photos.create(photo_params)
    render_success_response({ :photos => @photos}, 201)
  end

  def multi_destroy
    @album = Album.find(params[:album_id])
    if @album.photos.present?
      if params[:photos][:id].present?
        @selected_photos_delete = @album.photos.where("id IN (?)",params[:photos][:id]).destroy_all
        # puts "------selected-------#{@selected_photos_delete.inspect}-------------"
      else
        @all_delete = Photo.all
        @del_photos = @all_delete.destroy_all
        # puts "-------all delete------#{@all_delete.inspect}-------------"
      end
      # puts "------------success-------------"
      render_success_response({ :photos => @selected_photos_delete}, 201)
    else
      # puts "-------------not found-------------"
      json_response({success: false, message: "Photos not found"}, 400)
    end
  end

  private

  def photo_params
    params.require(:photos).map do |p|
      ActionController::Parameters.new(p).permit(:image, :photo_title, :album_id, :status, :added_by).merge(:added_by => current_resource_owner.id)
    end 
  end

end