class AddDeletedAtToServiceIcon < ActiveRecord::Migration[5.0]
  def change
    add_column :service_icons, :deleted_at, :datetime
    add_index :service_icons, :deleted_at
  end
end
