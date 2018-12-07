class Watermarks::WatermarkAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status, :dummy_image
  has_one :photo, key: "photo",serializer: Watermarks::PhotoAttributesSerializer

  def dummy_image
    CommonSerializer.full_image_url(object.user.photos.find_by(image_file_name: "dummy-image.jpg").image.url) if object.user.photos.find_by(image_file_name: "dummy-image.jpg").present?
  end
end