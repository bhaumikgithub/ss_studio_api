class RemoveAttachmentWatermarkImageToWatermarks < ActiveRecord::Migration[5.0]
  def change
  	remove_attachment :watermarks, :watermark_image
  end
end
