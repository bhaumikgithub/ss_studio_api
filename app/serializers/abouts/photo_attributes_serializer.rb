class Abouts::PhotoAttributesSerializer < ActiveModel::Serializer
  attributes :image
  def image
    URI.join(ActionController::Base.asset_host,object.image.url).to_s
  end
end