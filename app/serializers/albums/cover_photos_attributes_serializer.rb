class Albums::CoverPhotosAttributesSerializer < ActiveModel::Serializer
  attributes :image_file_name, :image
end