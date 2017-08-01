class Services::ServiceAttributesSerializer < ActiveModel::Serializer
  attributes :id, :service_name, :description, :status
  belongs_to :service_icon, key: "service_icon", serializer: Services::ServiceIconAttibutesSerializer
end