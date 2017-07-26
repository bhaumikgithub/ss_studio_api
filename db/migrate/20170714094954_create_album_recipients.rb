class CreateAlbumRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :album_recipients do |t|
      t.boolean :is_email_sent
      t.string :custom_message
      t.references :album, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
