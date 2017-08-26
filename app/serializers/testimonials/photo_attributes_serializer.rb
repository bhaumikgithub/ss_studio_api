class Testimonials::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :image_file_name, :image
  def image
  	style = instance_options[:style].present? ? instance_options[:style] : "original"
    CommonSerializer.full_image_url(object.image.url(style))
  end
end