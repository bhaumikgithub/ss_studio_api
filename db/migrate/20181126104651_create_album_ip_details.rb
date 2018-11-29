class CreateAlbumIpDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :album_ip_details do |t|
      t.references :album, foreign_key: true
      t.references :ip_detail, foreign_key: true

      t.timestamps
    end
  end
end
