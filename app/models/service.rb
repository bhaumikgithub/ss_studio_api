class Service < ApplicationRecord
  acts_as_paranoid
  # Callabcks
  # Associations
  belongs_to :service_icon
  # Enumerator
  enum status: { inactive: 0, active: 1 }
  # Validations
  validates :service_name, presence: true, :uniqueness => true
  validates_length_of :description, :minimum => 30, :maximum => 150
  # Scopes
  # Methods
end
