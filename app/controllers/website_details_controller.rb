class WebsiteDetailsController < ApplicationController
  include ProfileCompleteHelper
  skip_before_action :doorkeeper_authorize!, only: [ :website_details ]
  before_action :fetch_website_detail, only: [ :update, :show, :update_user_logo ]

  # GET /website_detail
  def show
    render_success_response({ :website_detail => @website_detail}, 200)
  end
  
  # GET /website_details
  def website_details
    render_success_response({ :website_detail => User.get_user(params[:user]).website_detail}, 200)
  end

  # POST  /website_details
  def create
    @website_detail = current_resource_owner.create_website_detail(resource_params)
    render_success_response({ :website_detail => @website_detail}, 201) if @website_detail
  end

  # PATCH /website_details
  def update
    @website_detail.update_attributes!(resource_params)
    if @website_detail.present? && !current_resource_owner.profile_completeness.website_detail
      next_task = next_task('website_detail')
      current_resource_owner.profile_completeness.update(website_detail: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    render_success_response({ :website_detail => @website_detail}, 201)
  end

  def update_user_logo
    @website_detail.update_attributes!(favicon_image: params[:website_detail][:favicon_image])
    json_response({
        success: true,
        data: {
          website_detail: single_record_serializer.new(@website_detail, serializer: WebsiteDetails::WebsiteDetailAttributesSerializer),
        }
      }, 201)
  end

  private

  def resource_params
    params.require(:website_detail).permit(:user_id, :favicon_image, :title, :copyright_text)
  end

  def fetch_website_detail
    @website_detail = current_resource_owner.website_detail
  end
end
