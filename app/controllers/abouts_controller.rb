class AboutsController < ApplicationController
  include InheritAction

  private

  def resource_params
    params.require(:about).permit(:title_text, :description, :facebook_link, :twitter_link, :instagram_link, photo_attributes: [:id, :image, :imageable_id, :imageable_type, :_destroy, :user_id])
  end
end
