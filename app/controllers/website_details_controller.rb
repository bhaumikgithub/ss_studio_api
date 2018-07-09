class WebsiteDetailsController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [ :website_details ]
  before_action :fetch_website_detail, only: [ :update, :show ]

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
    render_success_response({ :website_detail => @website_detail}, 201)
  end

  private

  def resource_params
    params.require(:website_detail).permit!
  end

  def fetch_website_detail
    @website_detail = current_resource_owner.website_detail
  end
end
