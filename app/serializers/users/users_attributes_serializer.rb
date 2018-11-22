class Users::UsersAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :alias, :phone, :first_name, :last_name, :start_plan_date, :end_plan_date
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  belongs_to :package, key: "subscription_package", serializer: Users::PackageAttributesSerializer

  def start_plan_date
    if object.active?
      start_date = object.package_users.where(package_status: 0)[0]&.package_start_date
      CommonSerializer.date_formate(start_date) if !start_date.nil?
    end
  end

  def end_plan_date
    if object.active?
      end_date = object.package_users.where(package_status: 0)[0]&.package_end_date
      CommonSerializer.date_formate(end_date) if !end_date.nil?
    end
  end
end