class CreateProfileCompletenesses < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_completenesses do |t|
      t.jsonb :album_management
      t.jsonb :site_content
      t.jsonb :homepage_gallery
      t.jsonb :video_portfolio
      t.jsonb :testimonial
      t.jsonb :contacts
      t.string :next_task
      t.integer :total_process
      t.integer :completed_process
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
