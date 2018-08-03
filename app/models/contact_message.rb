class ContactMessage < ApplicationRecord
  # Callabcks
  # Associations
  # Enumerator
  # Validations
  validates :name, :email, :phone, :message, presence: true
  validates :phone, :numericality => true
  cattr_accessor :captcha
  validate :captcha_code
  # Scopes
  # Methods

  def captcha_code
    errors.add("captcha","is invalid. Please Enter valid captcha") if self.captcha != "28"
  end
end
