class VideosController < ApplicationController

	# Callabcks
	before_action :fetch_video, only: [ :destroy, :update ]

	# GET    /videos
	def index
		@videos = current_resource_owner.videos
    render_success_response({ :videos => @videos })
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
    json_response({success: true, message: "video destroy successfully.", data: { :video => @video }}, 201)
  end

  # PATCH  /videos/:id
  def update
    @video.update_attributes!(resource_params)
    @video.update_attributes(video_thumb: @video.video.url(:thumb))
    json_response({success: true, message: "video update successfully.", data: { :video => @video }}, 201)
  end

	private

	def resource_params
    params.require(:video).permit(:user_id, :is_youtube_url, :is_vimeo_url, :video)
  end

  def fetch_video
  	@video = current_resource_owner.videos.find(params[:id])
  end
end
