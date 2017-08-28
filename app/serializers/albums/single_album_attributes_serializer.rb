class Albums::SingleAlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :is_private, :status, :updated_at, :created_at, :delivery_status, :portfolio_visibility, :passcode, :status, :photo_count, :recipients_count, :cover_photo
  has_many :photos, key: "photos", serializer: Albums::PhotoAttributesSerializer
  has_many :categories, key: "categories",serializer: Albums::SingleCategoriesAttributesSerializer

  def photo_count
    object.photos.count
  end

  def recipients_count
    object.album_recipients.count
  end

  def photos
    object.photos.where.not(is_cover_photo: true)
  end

  def cover_photo
    photo = object.photos.where(is_cover_photo: true).first
    if photo.present?
      {
        id: photo.id,
        image_file_name: photo.image_file_name,
        image: CommonSerializer.full_image_url(photo.image.url(:thumb))
      }
    else
      {
        image_file_name: "No image available",
        image: CommonSerializer.full_image_url("/shared_photos/missing.png")
      }
    end
  end

  def updated_at
    CommonSerializer.date_formate(object.updated_at)
  end

  def created_at
    CommonSerializer.date_formate(object.created_at)
  end
end