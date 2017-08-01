class HomepagePhotos::HomepagePhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :is_active, :homepage_image, :homepage_image_file_name
  belongs_to :photo, key: "photo", serializer: HomepagePhotos::ImageAttibutesSerializer

  def homepage_image
    if object.homepage_image.present?
    end
  end
end