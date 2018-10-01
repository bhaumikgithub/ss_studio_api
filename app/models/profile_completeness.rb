class ProfileCompleteness < ApplicationRecord
  belongs_to :user
  serialize [ :album_management, :site_content, :homepage_gallery, :video_portfolio, :testimonial, :contacts ]
  store_accessor :album_management, :public_album, :private_album, :watermark, :photo
  store_accessor :site_content, :about_us, :service, :contact_us, :social_media_link, :website_detail
  store_accessor :homepage_gallery, :homepage_gallery_photo
  store_accessor :video_portfolio, :youtube_video
  store_accessor :testimonial, :add_testimonial
  store_accessor :contacts, :contact_details
end
