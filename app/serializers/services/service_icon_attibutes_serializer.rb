class Services::ServiceIconAttibutesSerializer < ActiveModel::Serializer
  attributes :icon_image

  def icon_image
    CommonSerializer.full_image_url(object.icon_image)
  end
end