class WatermarksController < ApplicationController
  include InheritAction
  
  # Callabcks
  before_action :fetch_watermark, only: [ :update ]
  
  # GET /watermarks
  def index
    @watermarks = current_resource_owner.watermarks
    render_success_response({ :watermarks => @watermarks })
  end

  # POST /watermarks
  def create
    @watermark = current_resource_owner.watermarks.create(resource_params)
    current_resource_owner.watermarks.where.not(id: @watermark.id).update_all(status: 0)
    render_success_response({ :watermarks => @watermark }, 201)
  end

  # PATCH  /watermarks/:id
  def update
    super
    if @resource.status == "active"
      current_resource_owner.watermarks.where("status=(?) and ID NOT IN (?)",1,@resource.id).update_all(status: 0)
    end
  end

  private
  def resource_params
    params.require(:watermark).permit(:watermark_image, :user_id, :status )
  end

  def fetch_watermark
    @watermark = current_resource_owner.watermarks.find(id: params[:id])
  end
end
