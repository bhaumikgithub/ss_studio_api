class AddDeletedAtToContactDetail < ActiveRecord::Migration[5.0]
  def change
  	add_column :contact_details, :deleted_at, :datetime
    add_index :contact_details, :deleted_at
  end
end
