class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :user, foreign_key: true
      t.boolean :is_youtube_url, default: false
      t.boolean :is_vimeo_url, default: false

      t.timestamps
    end
  end
end
