class Album < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  has_many :album_categories, dependent: :destroy
  has_many :categories, through: :album_categories
  has_many :photos, dependent: :destroy
  belongs_to :watermark

  enum status: { inactive: 0, active: 1 }
  # Validations
  validates :album_name, presence: true, :uniqueness => true

  # Scopes

  private

  # Methods
end
