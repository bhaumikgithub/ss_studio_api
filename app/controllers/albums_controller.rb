class AlbumsController < ApplicationController
  include InheritAction

  before_action :fetch_album, only: [ :update, :destroy ]

  # GET /albums
  def index
    @albums = current_resource_owner.albums.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      "albums.updated_at DESC"
    )
    json_response({
      success: true,
      data: {
        albums: array_serializer.new(@albums, serializer: Albums::AlbumAttributesSerializer),
      },
      meta: meta_attributes(@albums)
    }, 200)
    # render_success_response({ :albums => @albums })
  end

  # POST /albums
  def create
    @album = current_resource_owner.albums.create!(album_params)

    json_response({
      success: true,
      data: {
        album: single_record_serializer.new(@album, serializer: Albums::AlbumAttributesSerializer),
      }
    }, 201)
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
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, :delivery_status, :portfolio_visibility, category_ids: [] )
  end

  def fetch_album
    @album = current_resource_owner.albums.find(params[:id])
  end
end
