class Users::UsersAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :alias, :phone, :first_name, :last_name, :start_plan_date, :end_plan_date
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  belongs_to :package, key: "subscription_package", serializer: Users::PackageAttributesSerializer

  def start_plan_date
    CommonSerializer.date_formate(object.start_plan_date) if object.start_plan_date.present?
  end

  def end_plan_date
    CommonSerializer.date_formate(object.end_plan_date) if object.end_plan_date.present?
  end
end