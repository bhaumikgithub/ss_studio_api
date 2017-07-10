class Contact < ApplicationRecord
  acts_as_paranoid
  
  # Callabcks
  after_create :generate_token

  # Associations
  belongs_to :user

  # Validations
  validates :phone, :email, presence: true, :uniqueness => true
  validates_length_of :phone, :minimum => 10, :maximum => 13
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Methods
  # generate uniq token
  def generate_token
    @token = SecureRandom.base58(10)
    self.update(token: @token)
  end
end
