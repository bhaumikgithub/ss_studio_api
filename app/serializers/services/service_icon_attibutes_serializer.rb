class Services::ServiceIconAttibutesSerializer < ActiveModel::Serializer
  attributes :icon_image

  def icon_image
    CommonSerializer.watermark_full_image_url(object.icon_image)
  end
end