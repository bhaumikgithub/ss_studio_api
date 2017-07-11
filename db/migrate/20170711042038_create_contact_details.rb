class CreateContactDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_details do |t|
      t.text :address
      t.string :email
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
