class RemovePackageIdIndexFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, name: "index_users_on_package_id"
    remove_column :users, :package_id, :integer
  end
end
