class AddIndexToCategory < ActiveRecord::Migration[5.0]
  def change
  	 add_index :categories, :user_id
  end
end
