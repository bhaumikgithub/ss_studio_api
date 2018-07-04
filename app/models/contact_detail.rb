class ContactDetail < ApplicationRecord
  belongs_to :user
  acts_as_paranoid
  
  # Callabcks

  # Associations

  # Validations
  validates :phone, presence: true, :uniqueness => {:scope=>:user_id}, :numericality => true 
  validates :email, presence: true, :uniqueness => {:scope=>:user_id}
  validates_length_of :phone, :minimum => 10, :maximum => 13
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Methods
end
