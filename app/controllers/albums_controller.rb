class AlbumsController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [ :portfolio, :show, :passcode_verification, :mark_as_submitted ]
  before_action :fetch_album, only: [ :update, :destroy, :show, :passcode_verification, :mark_as_submitted, :get_selected_photos, :get_commented_photos, :mark_as_deliverd, :mark_as_stoped_selection, :mark_as_shared, :acivate_album ]

  # GET /albums
  def index
    @albums = current_resource_owner.albums.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      "albums.#{params[:sorting_field]} #{params[:sorting_order]}"
    ).includes(
      :photos, :categories
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
        album: single_record_serializer.new(@album, serializer: Albums::SingleAlbumAttributesSerializer, params: params)
      }
    }, 200)
  end

  # PATCH/PUT /albums/:id
  def update
    @album.update_attributes!(album_params)
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

  # GET /albums/:id/passcode_verification?passcode=''
  def passcode_verification
    if @album.is_private?
      if @album.passcode === params[:passcode]
        json_response({success: true, message: "Passcode verification successfully."}, 200)
      else
        json_response({success: false, message: "Enter Valid Passcode.", errors: 'Invalid Passcode' }, 401)
      end
    end
  end

  #PUT /albums/:id/mark_as_submitted
  def mark_as_submitted
    response = SubmitAlbum.new(@album).call
    json_response({success: response.success?, message: response.message}, response.status)
  end

  # GET  /albums/:id/get_selected_photos
  def get_selected_photos
    @photos = @album.photos.where('is_selected = true')
    render_success_response({photos: array_serializer.new(@photos, serializer: Photos::CreatePhotoAttributesSerializer)}, 200)
  end

  # GET    /albums/:id/get_commented_photos
  def get_commented_photos
    @photos = @album.photos.joins(:comment)
    render_success_response({photos: array_serializer.new(@photos, serializer: Photos::CreatePhotoAttributesSerializer)}, 200)
  end

  # PUT    /albums/:id/mark_as_deliverd
  def mark_as_deliverd
    @album.update_attributes!(delivery_status: "Delivered")
    render_success_response({success: true}, 200)
  end

  # PUT    /albums/:id/mark_as_stoped_selection
  def mark_as_stoped_selection
    @album.update_attributes!(delivery_status: "Stoped_selection")
    render_success_response({success: true}, 200)
  end

  # PUT    /albums/:id/mark_as_shared
  def mark_as_shared
    @album.update_attributes!(delivery_status: "Shared")
    render_success_response({success: true}, 200)
  end

  # PUT    /albums/:id/acivate_album
  def acivate_album
    @album.update_attributes!(status: 1)
    render_success_response({success: true}, 200)
  end

  # GET    /albums/get_album_status_wise
  def get_album_status_wise
    albums = params[:checked] == "true" ? current_resource_owner.albums.where(status: params[:status]) : current_resource_owner.albums.where.not(status: params[:status])
    @albums = albums.page(
        params[:page]
      ).per(
        params[:per_page]
      ).order(
        "albums.#{params[:sorting_field]} #{params[:sorting_order]}"
      ).includes(
        :photos, :categories
      )
    json_response({
      success: true,
      data: {
        albums: array_serializer.new(@albums, serializer: Albums::AlbumAttributesSerializer),
      },
      meta: meta_attributes(@albums)
    }, 200)

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
