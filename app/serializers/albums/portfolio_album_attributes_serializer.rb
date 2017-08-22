class Albums::PortfolioAlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :cover_photo
  has_many :categories, key: "categories",serializer: Albums::CategoriesAttributesSerializer

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
end