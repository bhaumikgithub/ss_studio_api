class HomepagePhotosController < ApplicationController
  include InheritAction
  
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

  private
  
    def homepage_photo_params
      params.require(:homepage_photo).map do |p|
        ActionController::Parameters.new(p).permit(:homepage_image, :user_id, :is_active, :photo_id)
      end
    end 
  
end