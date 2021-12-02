class AlbumsController < ApplicationController
  include ProfileCompleteHelper
  include AlbumHelper
  skip_before_action :doorkeeper_authorize!, only: [ :portfolio, :show, :passcode_verification, :mark_as_submitted, :portfolio_album_detail, :shared_album_login, :passcode_verification_post, :view_album ]
  before_action :fetch_album, only: [ :update, :destroy, :show, :passcode_verification, :mark_as_submitted, :get_selected_photos, :get_commented_photos, :mark_as_deliverd, :mark_as_stoped_selection, :mark_as_shared, :acivate_album, :passcode_verification_post, :shared_album_login ]
  before_action :fetch_portfolio, only: [ :get_portfolio, :update_portfolio ]
  # GET /albums
  def index
    if params[:category_id].present?
      albums = current_resource_owner.categories.find_by(id: params[:category_id]).albums
    else
      albums = current_resource_owner.albums
    end
    @albums = albums.page(
        params[:page]
      ).per(
        params[:per_page]
      ).order(
        updated_at: :desc
      ).includes(
        :photos, :categories
      )
    @categories = current_resource_owner.categories

    json_response({
      success: true,
      data: {
        albums: array_serializer.new(@albums, serializer: Albums::AlbumAttributesSerializer),
        categories: { :categories => @categories },
      },
      meta: meta_attributes(@albums)
    }, 200)
    # render_success_response({ :albums => @albums })
  end

  # POST /albums
  def create
    @album = current_resource_owner.albums.create!(album_params)
    if @album.present?
      @album.update(owner_ip: request.remote_ip)
    end
    if @album.present? && !@album.is_private && !current_resource_owner.profile_completeness.public_album
      next_task = next_task('public_album')
      current_resource_owner.profile_completeness.update(public_album: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    elsif @album.present? && @album.is_private && !current_resource_owner.profile_completeness.private_album
      next_task = next_task('private_album')
      current_resource_owner.profile_completeness.update(private_album: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    json_response({
      success: true,
      data: {
        album: single_record_serializer.new(@album, serializer: Albums::AlbumAttributesSerializer),
      }
    }, 201)
  end

  # GET /albums/:id
  def show
    change_album_ip_detail
    if params[:user]
      @album = User.get_user(params[:user]).albums.find_by(slug: params[:id])
    end
    json_response({
      success: true,
      data: {
        album: single_record_serializer.new(@album, serializer: Albums::SingleAlbumAttributesSerializer, params: params)
      }
    }, 200)
  end

  def portfolio_album_detail
    @alias_name = params[:user]
    change_album_ip_detail
    if params[:user]
      @album = User.get_user(params[:user]).albums.find_by(slug: params[:id])
      @photos = @album.photos.page(
        params[:page]
      ).per(
        32
      ).order(
        updated_at: :desc
      )
    end
    respond_to do |format|
      format.html
    end
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
    @portfolio_detail = User.get_user(params[:user]).portfolio 
    if params[:category].present? && params[:category] != "all"
      category = Category.find_by_category_name(params[:category])
      @portfolio_albums = category.albums.where(user_id: User.get_user(params[:user]).id).order(updated_at: :desc)
    else
      @portfolio_albums = User.get_user(params[:user]).albums.order(updated_at: :desc)
    end

    @portfolio_albums = @portfolio_albums.where(status: "active", portfolio_visibility: true, is_private: false)
    if params[:onlyAPI].present? && params[:onlyAPI] == "true"
      json_response({
        success: true,
        data: {
          albums: array_serializer.new(@portfolio_albums, serializer: Albums::PortfolioAlbumAttributesSerializer),
        }
      }, 200)
    else
      @categories = User.get_user(params[:user]).categories.where(status: 'active')
      if @portfolio_detail.nil? || (@portfolio_detail.present? && @portfolio_detail.is_show)
        respond_to do |format|
          format.html
          format.js
        end
      else
        redirect_to active_homepage_photo_path
      end
    end
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

  def passcode_verification_post
    if @album.is_private?
      if @album.passcode === params[:passcode]
        @redirect_path = view_album_path(user: params[:user], id: @album.slug)
        session["album_#{@album&.id.to_s}".intern] = params[:passcode]
        redirect_to @album.user.try(:domain_name).present? ? @album.user.try(:domain_name)+@redirect_path.from(@redirect_path.index('/shared_album')) : view_album_path(user: params[:user], id: @album.slug)
        # redirect_to view_album_path(user: params[:user], id: @album.slug)
      else
        # redirect_to shared_album_login_path(user: params[:user], id: @album.slug, errors: 'Invalid Passcode')
        @redirect_path = shared_album_login_path(user: params[:user], id: @album.slug, errors: 'Invalid Passcode')
        redirect_to @album.user.try(:domain_name).present? ? @album.user.try(:domain_name)+@redirect_path.from(@redirect_path.index('/shared_album_login')) : shared_album_login_path(user: params[:user], id: @album.slug, errors: 'Invalid Passcode')
      end
    end
  end

  #PUT /albums/:id/mark_as_submitted
  def mark_as_submitted
    if @album.user.contact_detail.present?
      @admin_email = @album.user.contact_detail.email
    else
      @admin_email = @album.user.email
    end
    response = SubmitAlbum.new(@album, @admin_email).call
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
    if params[:category_id].present?
      albums = current_resource_owner.categories.find_by(id: params[:category_id]).albums
    else
      albums = current_resource_owner.albums
    end
    albums = params[:checked] == "true" ? albums.where(status: params[:status]) : albums.where.not(status: params[:status])
    @albums = albums.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      updated_at: :desc
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

  def view_album
    @alias_name = params[:user]
    change_album_ip_detail
    if params[:user]
      @album = User.get_user(params[:user]).albums.find_by(slug: params[:id])
      session["album_#{@album&.id.to_s}".intern]
      if @album.is_private && session["album_#{@album&.id.to_s}".intern] == @album.passcode
        @photos = @album.photos.page(
          params[:page]
        ).per(
          32
        ).order(
          updated_at: :desc
        )
      else
        redirect_to shared_album_login_path
      end
    end
  end
  
  def shared_album_login
  end

  def get_portfolio
    unless @portfolio.present?
      @portfolio = current_resource_owner.create_portfolio()
    end
    render_success_response({ :portfolio => @portfolio}, 200)
  end

  def update_portfolio
    unless @portfolio.present?
      @portfolio = current_resource_owner.create_portfolio(portfolio_params)
    else
      @portfolio.update_attributes!(portfolio_params)
    end
    render_success_response({ :portfolio => @portfolio}, 201)
  end

  private

  def album_params
    params.require(:album).permit( :album_name, :is_private, :created_by, :status, :delivery_status, :portfolio_visibility, :passcode, category_ids: [] )
  end

  def portfolio_params
    params.require(:portfolio).permit(:is_show, :gallery_column)
  end

  def fetch_album
    # @album = current_resource_owner.album.friendly.find(params[:id])
    @album = Album.friendly.find(params[:id])
  end

  def fetch_portfolio
    @portfolio = current_resource_owner.portfolio
  end

  def change_album_ip_detail
    client_ip = request.remote_ip
    @ip_detail = IpDetail.find_by(ip_address: client_ip)
    unless @ip_detail.present?
      @ip_detail = IpDetail.create(ip_address: client_ip)
    end
    add_update_album_ip_detail(client_ip)
  end

  def add_update_album_ip_detail(client_ip)
    if params[:is_track]
      if params[:user_id] == ""
        if @album.owner_ip != client_ip
          @album_ip_detail = AlbumIpDetail.find_by(album_id: @album.id, ip_detail_id: @ip_detail.id)
          if @album_ip_detail.present?
            @album_ip_detail.update(count: @album_ip_detail.count+1)
          else
            @album.album_ip_details.create(ip_detail_id: @ip_detail.id, count: 1)
          end
        end
      else
        if @album.user_id != params[:user_id].to_i
          @album_ip_detail = AlbumIpDetail.find_by(album_id: @album.id, user_id: params[:user_id])
          if @album_ip_detail.present?
            @album_ip_detail.update(count: @album_ip_detail.count+1)
          else
            @album.album_ip_details.create(ip_detail_id: @ip_detail.id, user_id: params[:user_id], count: 1)
          end
        end
      end
    end
  end
end
