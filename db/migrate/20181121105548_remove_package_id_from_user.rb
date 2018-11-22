class RemovePackageIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :users, column: :package_id
  end
end
