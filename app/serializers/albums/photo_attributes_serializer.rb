class Albums::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :image_file_name, :image, :original_image

  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end

  def original_image
    CommonSerializer.full_image_url(object.image.url)
  end
end