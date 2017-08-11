class Contacts::ContactAttributesSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :phone, :first_name, :last_name
  has_one :photo, key: "photo", serializer: Contacts::PhotoAttributesSerializer
end