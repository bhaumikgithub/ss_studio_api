class HomepagePhotosController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!, only: [ :active ]
  
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
    select_photos = []
    params[:homepage_photo][:photo_id].each do |photo|
      select_photos.push(current_resource_owner.homepage_photos.create!(selected_photo_params(photo)))
    end
    @select_photo = select_photos
    # render_success_response({ :homepage_photos => @select_photo}, 201)
    json_response({
      success: true,
      data: {
        homepage_photos: array_serializer.new(@select_photo, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer),
      }
    }, 200)
  end

  # PUT /homepage_photo/active_gallery_photo
  def active_gallery_photo
    gallery_photo = []
    params[:homepage_photo][:id].each do |homepage_photo|
      gallery_photo.push(homepage_photo)
    end
    @gallery_photo = current_resource_owner.homepage_photos.where("ID IN (?)", gallery_photo)
    @active_photo = @gallery_photo.update(is_active: true)
    @inactive_photo = HomepagePhoto.where.not(id: @active_photo.pluck(:id)).update_all(is_active: false)
    # render_success_response({ :homepage_photos => @active_photo}, 200)
    json_response({
      success: true,
      data: {
        homepage_photos: array_serializer.new(@active_photo, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer),
      }
    }, 200)

  end

  def active
    @active_photos = HomepagePhoto.where(is_active: true)
    json_response({
      success: true,
      data: {
        active_photos: array_serializer.new(@active_photos, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer),
      }
    }, 200)
    # render_success_response({ :homepage_photos => @active_photos}, 200)
  end

  private
  
    def homepage_photo_params
      params.require(:homepage_photo).map do |p|
        params_attributes(p)
      end
    end

    def selected_photo_params(id)
      action_params({photo_id: id}).permit(:photo_id)
    end

    def params_attributes(p)
      action_params(p).permit(:homepage_image, :user_id, :is_active, :photo_id)
    end 

    def action_params(p)
      ActionController::Parameters.new(p)
    end

end