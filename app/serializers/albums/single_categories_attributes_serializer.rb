class Albums::SingleCategoriesAttributesSerializer < ActiveModel::Serializer
  attributes :id, :category_name
end