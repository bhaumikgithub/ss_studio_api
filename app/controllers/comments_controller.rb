class CommentsController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :fetch_photo, only: [ :create ]
  include InheritAction

  def create
    @comment = @photo.create_comment!(resource_params)
    json_response({success: true, message: "comment created successfully.", data: { :comment => @comment }}, 201)
  end

  private

  def resource_params
    params.require(:comment).permit(:message)
  end

  def fetch_photo
    @photo = Photo.find(params[:id])
  end
end
