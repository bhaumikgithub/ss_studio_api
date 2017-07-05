# frozen_string_literal: true

# category model
class Category < ApplicationRecord
  # Callbacks

  # Associations

  # Validations
  validates :category_name, presence: true, uniqueness: true

  # Scopes

  # private

  # Methods
end
