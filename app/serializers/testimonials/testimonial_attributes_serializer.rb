class Testimonials::TestimonialAttributesSerializer < ActiveModel::Serializer
  attributes :id, :client_name, :message, :status, :user_id
  has_one :photo, key: "photo", serializer: Testimonials::PhotosAttributesSerializer 
  has_many :contact, serializer: Testimonials::ContactsAttributesSerializer
end
