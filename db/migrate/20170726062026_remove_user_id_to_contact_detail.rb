class RemoveUserIdToContactDetail < ActiveRecord::Migration[5.0]
  def change
    remove_reference :contact_details, :user, foreign_key: true
  end
end
