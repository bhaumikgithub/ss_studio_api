class AlbumsController < ApplicationController
  include InheritAction

  # POST /albums
  def create
    @album = Album.create(album_params)
    render_success_response({ :albums => @album}, 201)
  end

  private

  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, category_ids: []).merge(:created_by => current_resource_owner.id)
  end

end
