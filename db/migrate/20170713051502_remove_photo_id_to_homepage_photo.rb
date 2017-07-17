class RemovePhotoIdToHomepagePhoto < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :homepage_photos, :photo, foreign_key: true
  end
end
