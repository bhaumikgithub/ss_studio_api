class AddAliasToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :alias, :string
    add_column :users, :phone, :string
    add_reference :users, :country, foreign_key: true
    add_reference :users, :package, foreign_key: true
  end
end
