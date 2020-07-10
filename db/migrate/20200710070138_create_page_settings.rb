class CreatePageSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :page_settings do |t|
      t.boolean :is_show, default: true
      t.string :page_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
