class AddSomeFieldsToHomepagePhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :homepage_photos, :position, :integer
    add_column :homepage_photos, :slide_text, :string
    add_column :homepage_photos, :button_text, :string
    add_column :homepage_photos, :button_link, :string
    add_column :homepage_photos, :is_display_text, :boolean, default: false
    add_column :homepage_photos, :is_display_button, :boolean, default: false
  end
end
