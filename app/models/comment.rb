class Comment < ApplicationRecord
  belongs_to :photo

  # Validations
  validates :message, presence: true
end
