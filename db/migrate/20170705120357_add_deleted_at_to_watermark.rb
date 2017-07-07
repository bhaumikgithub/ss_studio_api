class AddDeletedAtToWatermark < ActiveRecord::Migration[5.0]
  def change
    add_column :watermarks, :deleted_at, :datetime
    add_index :watermarks, :deleted_at
  end
end
