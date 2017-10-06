class AddAdditionalFieldsToAlbumRecipients < ActiveRecord::Migration[5.0]
  def change
  	add_column :album_recipients, :minimum_photo_selection, :integer
  	add_column :album_recipients, :allow_comments, :boolean, default: true
  end
end
