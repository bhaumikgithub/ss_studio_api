class AddPasscodeToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :passcode, :string
  end
end
