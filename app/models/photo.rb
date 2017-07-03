class Photo < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :album

  enum status: { inactive: 0, active: 1 }
  # Validations
  
  has_attached_file :image, styles: {  thumb: "100x100>", medium: "300x300>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Scopes

  private

  # Methods
end
