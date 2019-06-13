class Albums::PortfolioAlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :cover_photo, :slug
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
        image: CommonSerializer.full_image_url("https://afterclix.s3.ap-south-1.amazonaws.com/shared_photos/missing.png")
      }
    end
  end
end