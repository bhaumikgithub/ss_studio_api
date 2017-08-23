class HomepagePhotos::HomepagePhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :is_active, :homepage_image, :homepage_image_file_name

  def homepage_image
      CommonSerializer.full_image_url(object.homepage_image.present? ? object.homepage_image.url(:medium) : object.photo.image.url(:medium))
  end

  def homepage_image_file_name
    object.homepage_image_file_name.present? ? object.homepage_image_file_name : object.photo.image_file_name
  end
end