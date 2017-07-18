class AddPhotoToHomepagePhoto < ActiveRecord::Migration[5.0]
  def change
    add_reference :homepage_photos, :photo, foreign_key: true
    change_column :homepage_photos, :is_active, :boolean, default: false
  end
end
