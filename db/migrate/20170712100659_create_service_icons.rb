class CreateServiceIcons < ActiveRecord::Migration[5.0]
  def change
    create_table :service_icons do |t|
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
