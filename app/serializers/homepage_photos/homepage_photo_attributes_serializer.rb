class HomepagePhotos::HomepagePhotoAttributesSerializer < ActiveModel::Serializer
  attributes :id, :homepage_image, :homepage_image_file_name, :position, :slide_text, :button_text, :button_link, :is_display_text, :is_display_button

  def homepage_image
    style = instance_options[:style].present? ? instance_options[:style] : "medium"
    CommonSerializer.full_image_url(object.homepage_image.present? ? object.homepage_image.url(style) : object.photo.image.url(style))
  end

  def homepage_image_file_name
    object.homepage_image_file_name.present? ? object.homepage_image_file_name : object.photo.image_file_name
  end
end