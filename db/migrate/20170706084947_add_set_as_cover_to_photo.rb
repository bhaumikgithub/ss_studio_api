class AddSetAsCoverToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :set_as_cover, :boolean, default: false
  end
end
