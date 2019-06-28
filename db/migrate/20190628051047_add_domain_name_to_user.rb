class AddDomainNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :domain_name, :string
  end
end
