class WebsiteDetail < ApplicationRecord
  belongs_to :user

  has_attached_file :favicon_image,
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
  validates_attachment_content_type :favicon_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "image/svg", "image/vnd.microsoft.icon", "image/x-icon"]

  validates :title, :copyright_text, presence: true
end
