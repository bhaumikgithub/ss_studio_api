class AddPhotoIdToWatermark < ActiveRecord::Migration[5.0]
  def change
    add_reference :watermarks, :photo, foreign_key: true
  end
end
