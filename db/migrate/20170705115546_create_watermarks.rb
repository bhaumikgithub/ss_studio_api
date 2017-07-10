class CreateWatermarks < ActiveRecord::Migration[5.0]
  def change
    create_table :watermarks do |t|
      t.references :user, foreign_key: true
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
