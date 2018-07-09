class CreateWebsiteDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :website_details do |t|
      t.string :title
      t.text :copyright_text
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
