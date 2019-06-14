class Watermark < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user
  # has_one :photo, as: :imageable, dependent: :destroy

  has_attached_file :watermark_image,
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
                    default_url: ""
	validates_attachment_content_type :watermark_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # accepts_nested_attributes_for :photo

  enum status: { inactive: 0, active: 1 }

  # Validations
 

  # Method

end
