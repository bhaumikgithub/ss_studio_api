class AlbumsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [:index, :update, :destroy]

  # GET /albums
  def index
    @albums = current_resource_owner.albums
    render_success_response({ :albums => @albums })
  end

  # POST /albums
  def create
    @album = current_resource_owner.albums.create!(album_params)
    render_success_response({ :albums => @album}, 201)
  end

  # PATCH/PUT /albums/:id
  def update
    @album.update_attributes(album_params)
    json_response({success: true, message: "Album update successfully.", data: {albums: @album}}, 201)
  end

  # DELETE /albums/:id
  def destroy
    @album.destroy!
    json_response({success: true, message: "Album destroy successfully.", data: {albums: @album}}, 200)
  end

  private

  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, category_ids: [] )
  end

  def fetch_album
    @album = current_resource_owner.albums.find(params[:id])
  end
end
