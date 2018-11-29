class AddIsDefaultToPackage < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :is_default, :boolean, default: false
    add_column :packages, :duration, :string
    add_column :packages, :status, :integer, default: 0
  end
end
