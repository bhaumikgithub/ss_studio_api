class RemoveCreatedByFromAlbum < ActiveRecord::Migration[5.0]
  def change
    remove_column :albums, :created_by, :string
  end
end
