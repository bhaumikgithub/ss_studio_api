class AddWatermarkIdToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_reference :albums, :watermark, foreign_key: true
  end
end
