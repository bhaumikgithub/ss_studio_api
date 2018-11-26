class Albums::AlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :is_private, :status, :updated_at, :delivery_status, :portfolio_visibility, :cover_photo, :slug, :created_at, :user_name,:album_recipients, :show_album_url, :passcode
  has_many :photos, key: "photo_count"
  has_many :categories, key: "categories",serializer: Albums::CategoriesAttributesSerializer

  def photos
    object.photos.count
  end

  def cover_photo
    photo = object.photos.where(is_cover_photo: true).first
    if photo.present?
      {
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

  def user_name
    object&.user&.alias
  end
  def updated_at
    CommonSerializer.date_formate(object.updated_at)
  end

  def created_at
    CommonSerializer.date_formate(object.created_at)
  end

  def album_recipients
    object.album_recipients.where("recipient_type=(?)",1)
  end

  def show_album_url
    ENV['FRONT_URL'] + object.user.alias + "/shared_album/" + object.slug
  end
end