class HomepagePhoto < ApplicationRecord
  # Callabcks
  # Associations
  belongs_to :user
  belongs_to :photo
  # Enumerator
  # Validations
  has_attached_file :homepage_image,
                    :styles => {
                      :original => {
                        :geometry => "1920x1920>"
                      },
                      :large => {
                        :geometry => "1024x768#"
                      },
                      :medium => {
                        :geometry => "270x270#"
                      },
                      :thumb => {
                        :geometry => "500x1000#"
                      }
                    },
                    storage: :s3,
                    s3_region: ENV['AWS_S3_REGION'],
                    s3_credentials: {
                      s3_host_name: ENV['AWS_S3_HOST_NAME'],
                      bucket: ENV['AWS_S3_BUCKET_PROD'],
                      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                      },
                    :s3_protocol => :https
  validates_attachment_content_type :homepage_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # Methods
end