class AddOwnerIpToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :owner_ip, :string
  end
end
