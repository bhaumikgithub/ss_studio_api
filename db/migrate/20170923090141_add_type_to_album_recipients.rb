class AddTypeToAlbumRecipients < ActiveRecord::Migration[5.0]
  def change
  	add_column :album_recipients, :type, :integer, :default => 0
  end
end
