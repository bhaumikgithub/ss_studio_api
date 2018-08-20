class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :phone, :photo_count, :first_name, :last_name, :phone, :alias
  has_one :user_logo, key: "user_logo",serializer: UserLogos::UserLogoAttributesSerializer
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  belongs_to :package, key: "subscription_package", serializer: Users::PackageAttributesSerializer

  def album_count
    object.albums.count
  end

  def photo_count
    object.albums.joins(:photos).count("photos.id")
  end
end