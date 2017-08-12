FactoryGirl.define do
  factory :video do
    user nil
    is_youtube_url false
    is_vimeo_url false
    video Rack::Test::UploadedFile.new('public/samplevideo.mp4')
  end
end
