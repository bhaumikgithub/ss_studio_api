class Albums::AlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :is_private, :status, :updated_at, :delivery_status
  has_many :photos, key: "photo_count"
  has_many :categories, key: "categories",serializer: Albums::CategoriesAttributesSerializer
  has_one :cover_photo, key: "cover_photo",serializer: Albums::CoverPhotosAttributesSerializer 

  def photos
    object.photos.count
  end

  def cover_photo
    if object.photos.present?
      object.photos.where(is_cover_photo: true).first
    end
  end

  def updated_at
    object.updated_at.strftime('%d-%m-%Y')
  end
end