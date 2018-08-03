class VideosController < ApplicationController

  # Callabcks
  skip_before_action :doorkeeper_authorize!, only: [ :publish, :update_position]
  before_action :fetch_video, only: [ :destroy, :update ]

  # GET    /videos
  def index
    @videos = current_resource_owner.videos.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      "videos.position asc","videos.updated_at desc"
    )
    json_response({
      success: true,
      data: {
        videos: array_serializer.new(@videos, serializer: Videos::VideoAttributesSerializer),
      },
      meta: meta_attributes(@videos)
    }, 200)
  end

  # POST   /videos
  def create
    @video = current_resource_owner.videos.create!(resource_params)
    @video.update_attributes(video_thumb: @video.video.url(:thumb))
    json_response({
      success: true,
      data: {
        video: single_record_serializer.new(@video, serializer: Videos::VideoAttributesSerializer),
      }
    }, 201)
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
    json_response({
      success: true,
      data: {
        video: single_record_serializer.new(@video, serializer: Videos::VideoAttributesSerializer),
      }
    }, 201)
  end

  # GET /videos/publish
  def publish
    @videos = Video.where(status: 'published').order(:position, :updated_at => :desc)
    json_response({
      success: true,
      data: {
        videos: array_serializer.new(@videos, serializer: Videos::VideoAttributesSerializer),
      }
    }, 200)
  end

  def update_position
    @video_position = Hash[*params[:video_position].flatten]
    @video_position.each do |key,value|
      Video.find(key).update_attributes(position: value)
    end
    @videos = current_resource_owner.videos.page(
      params[:page]
    ).per(
      params[:per_page]
    ).order(
      :position, :updated_at => :desc
    )
    json_response({
      success: true,
      data: {
        videos: array_serializer.new(@videos, serializer: Videos::VideoAttributesSerializer),
      }
    }, 201)
  end

  private

  def resource_params
    params.require(:video).permit(:title, :video_type, :video_url, :video_embed_url, :status, :video)
  end

  def fetch_video
    @video = current_resource_owner.videos.find(params[:id])
  end
end
