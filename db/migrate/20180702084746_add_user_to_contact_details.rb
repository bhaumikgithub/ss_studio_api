class AddUserToContactDetails < ActiveRecord::Migration[5.0]
  def change
    add_reference :contact_details, :user, foreign_key: true
    add_reference :services, :user, foreign_key: true
  end
end
