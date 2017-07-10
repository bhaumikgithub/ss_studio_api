class Album < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user
  has_many :album_categories
  has_many :categories, through: :album_categories, dependent: :destroy
  has_many :photos, as: :imageable, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  # Validations
  validates :album_name, presence: true, :uniqueness => true

  # Scopes

  private

  # Methods
end
