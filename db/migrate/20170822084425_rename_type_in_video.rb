class RenameTypeInVideo < ActiveRecord::Migration[5.0]
  def change
  	rename_column :videos, :type, :video_type
  end
end
