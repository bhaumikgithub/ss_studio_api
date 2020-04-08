class VideosController < ApplicationController
  include ProfileCompleteHelper
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
    if @video.present? && !current_resource_owner.profile_completeness.youtube_video
      next_task = next_task('youtube_video')
      current_resource_owner.profile_completeness.update(youtube_video: true, next_task: next_task, completed_process:current_resource_owner.profile_completeness.completed_process+1)
    end
    if (@video.video_type == "vimeo")
      video_id = @video.video_url.partition('vimeo.com/').last
      result = URI.parse("http://vimeo.com/api/v2/video/#{video_id}.json").read
      thumbnail_url = JSON.parse(result).first['thumbnail_large']
      @video.update_attributes(video_thumb: thumbnail_url)
    else
      @video.update_attributes(video_thumb: @video.video.url(:thumb))
    end

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
    if (@video.video_type == "vimeo")
      video_id = @video.video_url.partition('vimeo.com/').last
      result = URI.parse("http://vimeo.com/api/v2/video/#{video_id}.json").read
      thumbnail_url = JSON.parse(result).first['thumbnail_large']
      @video.update_attributes(video_thumb: thumbnail_url)
    else
      @video.update_attributes(video_thumb: @video.video.url(:thumb))
    end
    json_response({
      success: true,
      data: {
        video: single_record_serializer.new(@video, serializer: Videos::VideoAttributesSerializer),
      }
    }, 201)
  end

  # GET /videos/publish
  def publish
    @videos = User.get_user(params[:user]).videos.where(status: 'published').order(:position, :updated_at => :desc)
    if params[:onlyAPI].present? && params[:onlyAPI] == "true"
      json_response({
        success: true,
        data: {
          videos: array_serializer.new(@videos, serializer: Videos::VideoAttributesSerializer),
        }
      }, 200)
    else
      respond_to do |format|
        format.html
      end
    end
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
