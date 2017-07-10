class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.boolean :status, default: true
      t.references :created_by, references: :users

      t.timestamps
    end
  end
end
