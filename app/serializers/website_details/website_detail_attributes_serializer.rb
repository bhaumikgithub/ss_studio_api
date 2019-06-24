class WebsiteDetails::WebsiteDetailAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :favicon_image
  def favicon_image
    if Rails.env.development?
      CommonSerializer.full_image_url(ActionController::Base.asset_host + object&.favicon_image&.url(:original)) if object.favicon_image.present?
    else
      CommonSerializer.full_image_url(object&.favicon_image&.url(:original)) if object.favicon_image.present?
    end
  end
end
