class ServiceIcon < ApplicationRecord
  acts_as_paranoid
  # Callabcks
  # Associations
  has_many :services, dependent: :destroy
  # Enumerator
  enum status: { inactive: 0, active: 1 }
  # Validations
  # Scopes
  # Methods
end
