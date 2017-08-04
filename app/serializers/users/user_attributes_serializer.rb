class Users::UserAttributesSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :status, :album_count, :photo_count

  def album_count
    object.albums.count
  end

  def photo_count
  	binding.pry
    object.albums.last.photos.count
  end
end