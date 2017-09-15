class CommentsController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :fetch_photo, only: [ :create ]
  include InheritAction

  # POST /photos/:id/comments
  def create
    @comment = @photo.create_comment!(resource_params)
    render_success_response({ :comment => @comment }, 201)
  end

  private

  def resource_params
    params.require(:comment).permit(:message)
  end

  def fetch_photo
    @photo = Photo.find(params[:id])
  end
end
