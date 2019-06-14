class AddWatermarkImageAttachmentToWatermarks < ActiveRecord::Migration[5.0]
  def self.up
    change_table :watermarks do |t|
      t.attachment :watermark_image
    end
  end

  def self.down
    remove_attachment :watermarks, :watermark_image
  end
end
