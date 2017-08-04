class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :photo_count

  def album_count
    object.albums.count
  end

  def photo_count
    object.albums.joins(:photos).count("photos.id")
  end
end