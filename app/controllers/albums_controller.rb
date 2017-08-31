class AlbumsController < ApplicationController
  # include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :portfolio, :show, :passcode_verification ]
  before_action :fetch_album, only: [ :update, :destroy, :show, :passcode_verification ]

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

  # GET /albums/:id
  def show
    json_response({
      success: true,
      data: {
        album: single_record_serializer.new(@album, serializer: Albums::SingleAlbumAttributesSerializer),
      }
    }, 200)
  end
  
  # PATCH/PUT /albums/:id
  def update
    @album.update_attributes!(album_params)
    # json_response({success: true, message: "Album update successfully.", data: {album: @album}}, 201)
    json_response({
      success: true,
      message: "Album updated successfully.",
      data: {
        album: single_record_serializer.new(@album, serializer: Albums::AlbumAttributesSerializer),
      }
    }, 201)
  end

  # DELETE /albums/:id
  def destroy
    @album.destroy!
    json_response({success: true, message: "Album destroy successfully.", data: {albums: @album}}, 200)
  end

  # GET /albums/portfolio
  def portfolio
    if params[:category].present? && params[:category] != "all"
      category = Category.find_by_category_name(params[:category])
      @portfolio_albums = category.albums
    else
      @portfolio_albums = Album.all
    end

    @portfolio_albums = @portfolio_albums.where(status: "active", portfolio_visibility: true, is_private: false)
    json_response({
      success: true,
      data: {
        albums: array_serializer.new(@portfolio_albums, serializer: Albums::PortfolioAlbumAttributesSerializer),
      }
    }, 200)
  end

  # POST /albums/:id/passcode_verification
  def passcode_verification
    if @album.is_private?
      if @album.passcode === params[:params][:passcode]
        json_response({success: true, message: "Passcode verification successfully."}, 200)
      else
        json_response({success: false, message: "Enter Valid Passcode.", errors: 'Invalid Passcode' }, 401)
      end
    end
  end

  private

  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, :delivery_status, :portfolio_visibility, category_ids: [] )
  end

  def fetch_album
    # @album = current_resource_owner.album.friendly.find(params[:id])
    @album = Album.friendly.find(params[:id])
  end
end
