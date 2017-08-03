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

  def search
    @albums = current_resource_owner.albums.joins(:categories)
    
    if params[:category]
      @albums = @albums.where("categories.category_name = ? ", params[:category])
    end

    if params[:delivery_status]
      @albums = @albums.where("delivery_status = ? ", Album.delivery_statuses[params[:delivery_status].to_sym]).uniq
    end

    if params[:album_name]
      @albums = @albums.where("LOWER(album_name) LIKE ? ", "%#{params[:album_name]}%")
    end
    if params[:is_private]
      @albums = @albums.where("is_private  = ? ", params[:is_private]).uniq
    end
    render_success_response({ :results => @albums}, 201)
  end


  private
  
  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, :delivery_status, :portfolio_visibility, category_ids: [] )
  end

  def fetch_album
    @album = current_resource_owner.albums.find(params[:id])
  end
end
