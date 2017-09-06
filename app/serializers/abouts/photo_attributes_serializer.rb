class Abouts::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :image
  def image
    CommonSerializer.full_image_url(object.image.url(:medium))
  end
end