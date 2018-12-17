class Users::UsersAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :alias, :phone, :first_name, :last_name, :start_plan_date, :end_plan_date, :user_type, :created_at, :active_plan, :sub_package
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  has_many :packages, key: "subscription_package", serializer: Users::PackageAttributesSerializer

  def start_plan_date
    if object.active?
      start_date = object.package_users.where(package_status: 'active').last&.package_start_date
      CommonSerializer.date_formate(start_date) if !start_date.nil?
    elsif object.subscription_expire?
      start_date = object.package_users.where(package_status: 'expired').last&.package_start_date
      CommonSerializer.date_formate(start_date) if !start_date.nil?
    end
  end

  def end_plan_date
    if object.active?
      end_date = object.package_users.where(package_status: 'active').last&.package_end_date
      CommonSerializer.date_formate(end_date) if !end_date.nil?
    elsif object.subscription_expire?
      end_date = object.package_users.where(package_status: 'expired').last&.package_end_date
      CommonSerializer.date_formate(end_date) if !end_date.nil?
    end
  end

  def created_at
    CommonSerializer.date_formate(object.created_at)
  end

  def active_plan
    active_pkg_user = object.package_users.find_by(package_status: 'active')
    expired_pkg_user = object.package_users.where(package_status: 'expired').last
    if active_pkg_user.present?
      active_pkg_user.package.name
    elsif expired_pkg_user.present?
      expired_pkg_user.package.name
    end
  end

  def sub_package
    active_pkg_user = object.package_users.find_by(package_status: 'active')
    expired_pkg_user = object.package_users.where(package_status: 'expired').last
    if active_pkg_user.present?
      active_pkg_user.package
    elsif expired_pkg_user.present?
      expired_pkg_user.package
    end
  end
end