class ContactMessage < ApplicationRecord
  # Callabcks
  # Associations
  # Enumerator
  # Validations
  validates :name, presence: true
  validates :phone, presence: true, :numericality => true 
  validates :email, presence: true, :uniqueness => true
  # Scopes
  # Methods
end
