class PhotosController < ApplicationController
  include InheritAction

  def create
    @album = Album.find(params[:album_id])
    @album.photos.create(resource_params)
    # super do |resources|
    #   puts "----------#{resources.inspect }------------"
    #   # binding.pry
    #   resources.update_all(added_by: current_resource_owner.id)
    # end
  end

  # private

  def resource_params
    # params.permit(photos: [:image])
    params.require(:photos).map do |p|
      ActionController::Parameters.new(p).permit(:image, :photo_title, :album_id, :status, :added_by)
    end 
  end

end