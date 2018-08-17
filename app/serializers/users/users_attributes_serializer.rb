class Users::UsersAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :alias, :phone, :first_name, :last_name
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  belongs_to :package, key: "subscription_package", serializer: Users::PackageAttributesSerializer
end