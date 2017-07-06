class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :album_name
      t.string :created_by
      t.boolean :is_private
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
