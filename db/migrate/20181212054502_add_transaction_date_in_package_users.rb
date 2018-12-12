class AddTransactionDateInPackageUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :package_users, :transaction_date, :datetime
  end
end
