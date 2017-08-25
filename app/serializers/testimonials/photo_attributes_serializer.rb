class Testimonials::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :image_file_name, :image
  def image
    CommonSerializer.full_image_url(object.image.url)
  end
end