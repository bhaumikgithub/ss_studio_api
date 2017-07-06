class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :photos, :set_as_cover, :is_cover_photo
  end
end
