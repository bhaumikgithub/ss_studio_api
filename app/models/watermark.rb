class Watermark < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user

  enum status: { inactive: 0, active: 1 }

  # Validations
  has_attached_file :watermark_image,
                    styles: {  
                      thumb: "100x100#"
                    }
  validates_attachment_content_type :watermark_image, :content_type => ["image/png"]

  # Method

end
