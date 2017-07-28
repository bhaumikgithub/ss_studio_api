class CreateHomepagePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :homepage_photos do |t|
      t.boolean :is_active, default: true
      t.references :photo, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
