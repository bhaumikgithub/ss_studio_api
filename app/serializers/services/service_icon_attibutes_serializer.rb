class Services::ServiceIconAttibutesSerializer < ActiveModel::Serializer
  attributes :icon_image

  def icon_image
    URI.join(ActionController::Base.asset_host,object.icon_image).to_s 
  end
end