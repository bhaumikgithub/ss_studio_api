FactoryGirl.define do
  factory :photo do
    photo_title "photo"
    status 1
    image Rack::Test::UploadedFile.new('public/watermark.png')
    is_cover_photo false
    # imageable_type "Album"
    # imageable_id 
  end
end
