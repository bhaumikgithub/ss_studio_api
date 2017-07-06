class AddAttachmentWatermarkImageToWatermarks < ActiveRecord::Migration
  def self.up
    change_table :watermarks do |t|
      t.attachment :watermark_image
    end
  end

  def self.down
    remove_attachment :watermarks, :watermark_image
  end
end
