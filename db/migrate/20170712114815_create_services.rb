class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :description
      t.integer :status, :default => 1
      t.references :service_icon, foreign_key: true

      t.timestamps
    end
  end
end
