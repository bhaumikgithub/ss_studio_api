class AddIsSelectedToPhotos < ActiveRecord::Migration[5.0]
  def self.up
  	add_column :photos, :is_selected, :boolean, default: false
  end

  def self.down
  	remove_column :photos, :is_selected
  end
end
