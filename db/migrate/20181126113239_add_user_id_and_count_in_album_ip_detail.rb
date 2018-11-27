class AddUserIdAndCountInAlbumIpDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :album_ip_details, :user_id, :integer
    add_column :album_ip_details, :count, :integer
  end
end
