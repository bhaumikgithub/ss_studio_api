class Photos::CreatePhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :photo_title, :status, :is_cover_photo, :user_id, :imageable_type, :imageable_id, :is_selected, :image_file_name, :image
  
  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end
end