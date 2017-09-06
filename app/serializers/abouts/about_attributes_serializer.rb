class Abouts::AboutAttributesSerializer < ActiveModel::Serializer
  attributes :id, :title_text, :description, :facebook_link
  has_one :photo, key: "photo",serializer: Abouts::PhotoAttributesSerializer 
end