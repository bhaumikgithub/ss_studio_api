class WebsiteDetail < ApplicationRecord
  belongs_to :user

  has_attached_file :favicon_image,
                    :style => { :original => '300x400', :thumb => '120x120' },
                    storage: :s3,
                    s3_region: ENV['AWS_S3_REGION'],
                    s3_credentials: {
                      s3_host_name: ENV['AWS_S3_HOST_NAME'],
                      bucket: ENV['AWS_S3_BUCKET_PROD'],
                      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                      },
                    :s3_protocol => :https
  validates_attachment_content_type :favicon_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "image/svg", "image/vnd.microsoft.icon", "image/x-icon"]

  validates :title, :copyright_text, presence: true
end
