class CreateAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :abouts do |t|
      t.string :title_text
      t.string :description
      t.jsonb :social_links,default: '{}'

      t.timestamps
    end
  end
end
