class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.boolean :is_show, default: false
      t.string :blog_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
