class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :phone, :photo_count, :first_name, :last_name, :phone, :alias, :user_type
  has_one :user_logo, key: "user_logo",serializer: UserLogos::UserLogoAttributesSerializer
  belongs_to :role, serializer: Roles::RoleAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer
  has_many :packages, key: "subscription_package", serializer: Users::PackageAttributesSerializer
  belongs_to :country, serializer: Users::CountryAttributesSerializer

  def album_count
    object.albums.count
  end

  def photo_count
    object.albums.joins(:photos).count("photos.id")
  end
end