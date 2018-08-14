class Users::UsersAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :alias, :phone
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
end