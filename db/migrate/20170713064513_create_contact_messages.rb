class CreateContactMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_messages do |t|
      t.text :name
      t.string :email
      t.string :phone
      t.string :message

      t.timestamps
    end
  end
end
