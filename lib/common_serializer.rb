class CommonSerializer
  def self.full_image_url(image_url)
    URI.join(ActionController::Base.asset_host,image_url).to_s
  end
end