class Albums::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :image_file_name, :image, :original_image, :is_cover_photo, :is_selected, :comment_id

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

  def comment_id
    object.comment.try(:id)
  end
end