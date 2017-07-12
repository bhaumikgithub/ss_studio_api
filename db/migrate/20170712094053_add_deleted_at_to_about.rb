class AddDeletedAtToAbout < ActiveRecord::Migration[5.0]
  def change
    add_column :abouts, :deleted_at, :datetime
    add_index :abouts, :deleted_at
  end
end
