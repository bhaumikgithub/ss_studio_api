class AddStartDateEndDateInPackageUser < ActiveRecord::Migration[5.0]
  def change
    add_column :package_users, :package_start_date, :datetime
    add_column :package_users, :package_end_date, :datetime
  end
end
