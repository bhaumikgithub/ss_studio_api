class Abouts::AboutAttributesSerializer < ActiveModel::Serializer
  attributes :id, :title_text, :description, :social_links
  has_one :photo, key: "photo",serializer: Abouts::PhotoAttributesSerializer 
end