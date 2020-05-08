class CreateWidgets < ActiveRecord::Migration[5.0]
  def change
    create_table :widgets do |t|
      t.string :title
      t.text :code
      t.string :widget_type
      t.boolean :is_active, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
