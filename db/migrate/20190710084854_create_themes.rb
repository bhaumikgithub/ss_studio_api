class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.jsonb :color_theme
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
