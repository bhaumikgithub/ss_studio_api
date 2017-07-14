class HomepagePhotosController < ApplicationController
  include InheritAction
  
  #callbacks
  before_action :fetch_gallery_photo, only: [:active_gallery_photo]
  
  # GET /homepage_photos
  def index
    @homepage_photos = current_resource_owner.homepage_photos
    render_success_response({ :homepage_photos => @homepage_photos }, 200)
  end
  # POST /homepage_photos
  def create
    @homepage_photo = current_resource_owner.homepage_photos.create!(homepage_photo_params)
    render_success_response({ :homepage_photos => @homepage_photo}, 201)
  end

  # PUT /homepage_photos/select_uploaded_photo
  def select_uploaded_photo
    @select_photo = current_resource_owner.homepage_photos.create!(homepage_photo_params)
    render_success_response({ :homepage_photos => @select_photo}, 201)
  end

  # PUT /homepage_photo/active_gallery_photo
  def active_gallery_photo
    @active_photo = @gallery_photo.update(is_active: true)
    @inactive_photo = HomepagePhoto.where.not(id: @active_photo.pluck(:id)).update_all(is_active: false)
    render_success_response({ :homepage_photos => @active_photo}, 200)

  end

  private
  
    def homepage_photo_params
      params.require(:homepage_photo).map do |p|
        ActionController::Parameters.new(p).permit(:homepage_image, :user_id, :is_active, :photo_id)
      end
    end 

    # fetch id from homepage gallery for the active gallery photo
    def fetch_gallery_photo
      gallery_photo_ids = []
      params[:homepage_photo].each do |homepage_photo|
        gallery_photo_ids.push(homepage_photo[:id])
      end
      @gallery_photo = current_resource_owner.homepage_photos.where("ID IN (?)", gallery_photo_ids)
    end
  
end