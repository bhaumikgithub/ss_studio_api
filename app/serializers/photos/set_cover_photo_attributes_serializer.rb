class Photos::SetCoverPhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :image_file_name, :image, :is_cover_photo
  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end
end