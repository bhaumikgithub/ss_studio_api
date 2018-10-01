class HomepagePhotosController < ApplicationController
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :active, :index ]
  before_action :fetch_homepage_photo, only: [ :update ]

  # GET /homepage_photos
  def index
    @homepage_photos = current_resource_owner.homepage_photos.order('created_at desc')
    json_response({
      success: true,
      data: {
        active_photos: array_serializer.new(@homepage_photos, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer, style: "medium"),
      }
    }, 200)
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
    json_response({
      success: true,
      data: {
        homepage_photos: array_serializer.new(@active_photo, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer),
      }
    }, 201)

  end

  # GET /homepage_photos/active
  def active
    response = CommonService.is_mobile_devise(request)
    if params[:user]
      @active_photos = User.get_user(params[:user]).homepage_photos.where(is_active: true).order('created_at desc')
    else
      @active_photos = []
    end
    @style = response.present? ? "large" : "original"
      json_response({
        success: true,
        data: {
          active_photos: array_serializer.new(@active_photos, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer, style: @style),
        }
      }, 200)
  end

  #  PATCH /homepage_photos/:id
  def update
    @homepage_photo.update_attributes(resource_params)
    if @homepage_photo.present? && !current_resource_owner.profile_completeness.homepage_gallery_photo
      next_task = next_task('homepage_gallery_photo')
      current_resource_owner.profile_completeness.update(homepage_gallery_photo: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    json_response({
      success: true,
      data: {
        homepage_photo: single_record_serializer.new(@homepage_photo, serializer: HomepagePhotos::HomepagePhotoAttributesSerializer),
      }
    }, 201)
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

  def fetch_homepage_photo
    @homepage_photo = current_resource_owner.homepage_photos.find(params[:id])
  end

  def resource_params
    params.require(:homepage_photo).permit(:homepage_image)
  end

end