FactoryGirl.define do
  factory :photo do
    photo_title "photo"
    status 1
    image_file_name "public/download.jpg"
    image_content_type "image/jpeg"
    image_file_size 6826
    is_cover_photo false
    imageable_type ""
    imageable_id 1
  end
end
