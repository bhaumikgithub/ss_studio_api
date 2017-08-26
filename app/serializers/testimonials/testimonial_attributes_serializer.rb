class Testimonials::TestimonialAttributesSerializer < ActiveModel::Serializer
  attributes :id, :client_name, :message, :status, :rating, :user_id
  has_one :photo, key: "photo", serializer: Testimonials::PhotoAttributesSerializer 
  has_many :contact, serializer: Testimonials::ContactsAttributesSerializer
end
