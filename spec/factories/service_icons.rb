FactoryGirl.define do
  factory :service_icon do
    status 1
    icon_image Rack::Test::UploadedFile.new('public/watermark.png')
  end
end
