class CreateAlbumCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :album_categories do |t|
      t.references :album, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
