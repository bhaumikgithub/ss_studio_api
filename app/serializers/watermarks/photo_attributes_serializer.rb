class Watermarks::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :image, :original_image
  def image
    CommonSerializer.full_image_url(object.image.url(:medium))
  end

  def original_image
    CommonSerializer.full_image_url(object.image.url)
  end
end