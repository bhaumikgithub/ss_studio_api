class AddPackageStatusInPackageUser < ActiveRecord::Migration[5.0]
  def change
    add_column :package_users, :package_status, :integer
  end
end
