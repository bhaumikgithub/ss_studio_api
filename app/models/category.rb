class Category < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user
  has_many :album_categories, dependent: :destroy
  has_many :albums, through: :album_categories

  enum status: { inactive: 0, active: 1 }
  # Validations
  validates :category_name, presence: true, :uniqueness => true

  # Scopes

  private

  # Methods

end
