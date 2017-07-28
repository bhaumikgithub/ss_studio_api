class AddAttachmentHomepageImageToHomepagePhotos < ActiveRecord::Migration
  def self.up
    change_table :homepage_photos do |t|
      t.attachment :homepage_image
    end
  end

  def self.down
    remove_attachment :homepage_photos, :homepage_image
  end
end
