class AddDeletedAtToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :deleted_at, :datetime
    add_index :photos, :deleted_at
  end
end
