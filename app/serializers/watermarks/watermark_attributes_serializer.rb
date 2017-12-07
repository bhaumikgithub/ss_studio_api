class Watermarks::WatermarkAttributesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status
  has_one :photo, key: "photo",serializer: Watermarks::PhotoAttributesSerializer
end