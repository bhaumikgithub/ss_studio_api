class AddUserIdToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :user_id, :integer, index: true
  end
end
