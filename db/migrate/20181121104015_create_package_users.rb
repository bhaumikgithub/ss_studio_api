class CreatePackageUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :package_users do |t|
      t.references :package, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
