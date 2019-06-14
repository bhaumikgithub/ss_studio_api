class Watermarks::WatermarkAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status, :dummy_image, :watermark_image, :image, :original_image
  # has_one :photo, key: "photo",serializer: Watermarks::PhotoAttributesSerializer

  def dummy_image
    CommonSerializer.full_image_url(object.user.photos.find_by(image_file_name: "dummy-image.jpg").image.url(:large)) if object.user.photos.find_by(image_file_name: "dummy-image.jpg").present?
  end

  def image
    CommonSerializer.watermark_full_image_url(object.watermark_image.url(:medium))
  end

  def original_image
  	if object.watermark_image.path.present?
    	CommonSerializer.watermark_full_image_url(object.watermark_image.url)
    end
  end
end