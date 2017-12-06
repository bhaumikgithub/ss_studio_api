class Photos::CreatePhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :photo_title, :status, :is_cover_photo, :user_id, :imageable_type, :imageable_id, :image_file_name, :image, :original_image, :comment_id
  
  def image
    CommonSerializer.full_image_url(object.image.url(:thumb))
  end

  def original_image
    CommonSerializer.full_image_url(object.image.url)
  end

  def comment_id
    object.comment.try(:id)
  end
end