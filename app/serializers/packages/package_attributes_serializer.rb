class Packages::PackageAttributesSerializer < ActiveModel::Serializer
	attributes :id, :name, :price, :duration, :is_default, :days, :status, :created_at, :updated_at
end
