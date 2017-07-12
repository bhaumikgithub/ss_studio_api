class AddPolymorpicToPhoto < ActiveRecord::Migration[5.0]
  def change
  	add_reference :photos, :imageable, polymorphic: true, index: true
  	remove_column :photos, :album_id, :integer
  end
end
