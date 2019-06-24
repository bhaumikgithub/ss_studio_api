class AddAttachmentFaviconImageToWebsiteDetails < ActiveRecord::Migration
  def self.up
    change_table :website_details do |t|
      t.attachment :favicon_image
    end
  end

  def self.down
    remove_attachment :website_details, :favicon_image
  end
end
