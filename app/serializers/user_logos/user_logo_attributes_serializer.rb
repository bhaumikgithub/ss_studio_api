class UserLogos::UserLogoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :image
  def image
  	CommonSerializer.full_image_url(object&.photo&.image&.url(:original)) if object.photo.present?
  end
end