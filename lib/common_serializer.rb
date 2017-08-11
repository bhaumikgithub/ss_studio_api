class CommonSerializer
  def self.full_image_url(image_url)
    (ActionController::Base.asset_host + image_url).to_s
  end

  def self.date_formate(date)
  	date.strftime('%d-%m-%Y')
  end
end