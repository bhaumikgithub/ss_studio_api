class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.boolean :is_show, default: true
      t.integer :gallery_column, default: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
