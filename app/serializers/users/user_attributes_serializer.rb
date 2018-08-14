class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :phone, :photo_count
  has_one :user_logo, key: "user_logo",serializer: UserLogos::UserLogoAttributesSerializer

  def album_count
    object.albums.count
  end

  def photo_count
    object.albums.joins(:photos).count("photos.id")
  end
end