class Photos::SetCoverPhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :image_file_name, :image
  
  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end
end