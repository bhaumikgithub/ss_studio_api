class Photos::SetCoverPhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :image_file_name, :image, :is_cover_photo, :original_image, :is_selected

  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end

  def original_image
    if object.image.exists?(:large)
      CommonSerializer.full_image_url(object.image.url(:large))
    else
      CommonSerializer.full_image_url(object.image.url)
    end
  end
end