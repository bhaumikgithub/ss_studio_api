class UserLogos::GetUserLogoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :image
  def image
    CommonSerializer.full_image_url(object&.photo&.image&.url(:logo)) if object.photo.present?
  end
end