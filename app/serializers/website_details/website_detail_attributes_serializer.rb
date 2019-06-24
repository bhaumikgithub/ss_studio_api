class WebsiteDetails::WebsiteDetailAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :favicon_image
  def favicon_image
    CommonSerializer.full_image_url(object&.favicon_image&.url(:original)) if object.favicon_image.present?
  end
end
