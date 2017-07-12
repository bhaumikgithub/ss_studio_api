class RemovePhotoIdToWatermark < ActiveRecord::Migration[5.0]
  def change
    remove_reference :watermarks, :photo, foreign_key: true
  end
end
