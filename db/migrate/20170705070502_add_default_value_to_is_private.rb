class AddDefaultValueToIsPrivate < ActiveRecord::Migration[5.0]
  def change
  	change_column :albums, :is_private, :boolean, default: true
  end
end
