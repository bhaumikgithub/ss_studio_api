class Testimonials::ContactsAttributesSerializer < ActiveModel::Serializer
  attributes :full_name, :email, :phone, :status, :user_id, :token, :created_at, :updated_at, :deleted_at
end