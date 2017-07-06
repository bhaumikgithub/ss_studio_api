class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :photo_title
      t.integer :album_id
      t.integer :status, :default => 1
      t.string :added_by

      t.timestamps
    end
  end
end
