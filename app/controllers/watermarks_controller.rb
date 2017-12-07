class WatermarksController < ApplicationController
  include InheritAction
  
  # Callabcks
  before_action :fetch_watermark, only: [ :update ]
  
  # GET /watermarks
  def index
    @watermarks = current_resource_owner.watermarks
    json_response({
      success: true,
      data: {
        watermarks: array_serializer.new(@watermarks, serializer: Watermarks::WatermarkAttributesSerializer),
      }
    }, 200)
  end

  # POST /watermarks
  def create
    @watermark = current_resource_owner.watermarks.create(resource_params)
    current_resource_owner.watermarks.where.not(id: @watermark.id).update_all(status: 0)
    render_success_response({ :watermarks => @watermark }, 201)
  end

  # PATCH  /watermarks/:id
  def update
    @watermark.update_attributes!(resource_params)
    if @watermark.status == "active"
      current_resource_owner.watermarks.where("status=(?) and ID NOT IN (?)",1,@resource.id).update_all(status: 0)
    end
    json_response({
      success: true,
      data: {
        watermark: single_record_serializer.new(@watermark, serializer: Watermarks::WatermarkAttributesSerializer),
      }
    }, 201)
  end

  private
  def resource_params 
    # params[:watermark][:photo_attributes]["user_id"] = current_resource_owner.id
    params.require(:watermark).permit(:status, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id] )
  end

  def fetch_watermark
    @watermark = current_resource_owner.watermarks.find(params[:id])
  end
end
