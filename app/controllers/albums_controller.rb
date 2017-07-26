class AlbumsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [ :update, :destroy, :mark_as_submitted ]

  # GET /albums
  def index
    @albums = current_resource_owner.albums
    json_response({
      success: true,
      data: {
        albums: array_serializer.new(@albums, serializer: Albums::AlbumAttributesSerializer),
      }
    }, 200)
    # render_success_response({ :albums => @albums })
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

  #PUT /albums/:id/mark_as_submitted
  def mark_as_submitted
    if @album.delivery_status == "Submitted"
      json_response({success: false, message: "Album already submitted."})
    else
      @album.update_attribute :delivery_status, "Submitted"
      json_response({success: true, message: "Album successfully submitted."}, 201)
    end
  end

  private

  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, :delivery_status, :portfolio_visibility, category_ids: [] )
  end

  def fetch_album
    @album = current_resource_owner.albums.find(params[:id])
  end
end
