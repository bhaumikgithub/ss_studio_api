class Videos::VideoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :title, :video_type, :status, :video_url, :video_thumb, :updated_at

  def created_at
    CommonSerializer.date_formate(object.created_at)
  end

  def updated_at
    CommonSerializer.date_formate(object.updated_at)
  end

  def video_thumb
    CommonSerializer.full_image_url(object.video_thumb)
  end
end