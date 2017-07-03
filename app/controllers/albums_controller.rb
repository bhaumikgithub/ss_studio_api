class AlbumsController < ApplicationController
  include InheritAction

  private
  def permitted_attributes
    ["album_name", "created_by", "is_private", "status", category_ids: []]
  end

end
