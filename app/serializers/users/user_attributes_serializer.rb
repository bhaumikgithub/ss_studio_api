class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :phone, :photo_count, :first_name, :last_name, :phone, :alias, :user_type, :start_plan_date, :end_plan_date, :created_at, :active_plan, :sub_package, :domain_name
  has_one :user_logo, key: "user_logo",serializer: UserLogos::UserLogoAttributesSerializer
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  has_many :packages, key: "subscription_package", serializer: Users::PackageAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  has_one :website_detail, key: "website_detail",serializer: WebsiteDetails::WebsiteDetailAttributesSerializer

  def album_count
    object.albums.count
  end

  def photo_count
    object.albums.joins(:photos).count("photos.id")
  end

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