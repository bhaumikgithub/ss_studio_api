class Albums::CategoriesAttributesSerializer < ActiveModel::Serializer
  attributes :id, :category_name, :status
end
