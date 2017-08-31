class ContactMessage < ApplicationRecord
  # Callabcks
  # Associations
  # Enumerator
  # Validations
  validates :name, :email, :phone, :message, presence: true
  validates :phone, :numericality => true
  # Scopes
  # Methods
end
