class AddIconImageToServiceIcon < ActiveRecord::Migration[5.0]
  def change
    add_column :service_icons, :icon_image, :string
  end
end
