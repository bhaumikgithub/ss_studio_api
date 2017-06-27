class Category < ApplicationRecord
  # Callabcks

  # Associations

  # Validations
  validates :category_name, presence: true, :uniqueness => true

  # Scopes

  private

  # Methods

end
