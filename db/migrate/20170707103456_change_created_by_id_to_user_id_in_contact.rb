class ChangeCreatedByIdToUserIdInContact < ActiveRecord::Migration[5.0]
  def change
  	rename_column :contacts, 'created_by_id', 'user_id'
  end
end
