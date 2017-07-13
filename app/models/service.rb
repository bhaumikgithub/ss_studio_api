class Service < ApplicationRecord
  # Callabcks
  # Associations
  belongs_to :service_icon
  # Enumerator
  # Validations
  validates :service_name, presence: true, :uniqueness => true
  validates_length_of :description, :minimum => 30, :maximum => 150
  # Scopes
  # Methods
end
