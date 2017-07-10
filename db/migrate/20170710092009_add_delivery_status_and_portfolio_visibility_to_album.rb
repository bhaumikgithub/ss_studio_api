class AddDeliveryStatusAndPortfolioVisibilityToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :delivery_status, :integer, :default => 0
    add_column :albums, :portfolio_visibility, :boolean, :default => false
  end
end
