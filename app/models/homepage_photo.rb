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
                    :s3_protocol => :https
  validates_attachment_content_type :homepage_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # Methods
end