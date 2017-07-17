class HomepagePhoto < ApplicationRecord
  # Callabcks
  # Associations
  belongs_to :user
  belongs_to :photo
  # Enumerator
  # Validations
  has_attached_file :homepage_image,
                    :styles => {
                      :small => {
                        :geometry => "200x200#"
                      },
                      :medium => {
                        :geometry => "500x500#"
                      },
                      :thumb => {
                        :geometry => "500x1000#"
                      }
                    }
  validates_attachment_content_type :homepage_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # Methods
end