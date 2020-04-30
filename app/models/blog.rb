class Blog < ApplicationRecord
  belongs_to :user

  validates :blog_url, presence: true
end
