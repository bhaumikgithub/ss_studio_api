class WebsiteDetail < ApplicationRecord
  belongs_to :user

  validates :title, :copyright_text, presence: true
end
