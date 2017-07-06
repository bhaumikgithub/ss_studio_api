class AddStatusToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :status, :integer, :default => 1
  end
end
