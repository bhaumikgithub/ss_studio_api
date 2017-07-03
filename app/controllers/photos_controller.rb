class PhotosController < ApplicationController
  include InheritAction

  private
  def permitted_attributes
    [ "photo_title", "album_id", "status", "added_by", "image" ]
  end

end