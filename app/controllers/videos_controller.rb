class VideosController < ApplicationController

  # Callabcks
  before_action :fetch_video, only: [ :destroy, :update ]

  # GET    /videos
  def index
    @videos = current_resource_owner.videos
    json_response({
      success: true,
      data: {
        videos: array_serializer.new(@videos, serializer: Videos::VideoAttributesSerializer),
      }
    }, 200)
  end

  # POST   /videos
  def create
    @video = current_resource_owner.videos.create!(resource_params)
    @video.update_attributes(video_thumb: @video.video.url(:thumb))
    render_success_response({ :video => @video }, 201)
  end

  # DELETE /videos/:id
  def destroy
    @video.destroy!
    head 200
  end

  # PATCH  /videos/:id
  def update
    @video.update_attributes!(resource_params)
    @video.update_attributes(video_thumb: @video.video.url(:thumb))
    render_success_response({ :video => @video }, 201)
  end

  private

  def resource_params
    params.require(:video).permit(:title, :video_type, :video_url, :status, :video)
  end

  def fetch_video
    @video = current_resource_owner.videos.find(params[:id])
  end
end
