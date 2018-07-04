class Contact < ApplicationRecord
  acts_as_paranoid

  attr_accessor :not_validate

  # Callabcks
  after_create :generate_token

  # Associations
  belongs_to :user
  has_many :album_recipients, dependent: :destroy
  has_many :testimonials, dependent: :destroy
  has_one :photo, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo
  # Validations
  validates :first_name, presence: true, :unless => Proc.new{ not_validate&.include?('first_name') }
  validates :last_name, presence: true, :unless => Proc.new{ not_validate&.include?('last_name') }
  validates :phone, presence: true, :unless => Proc.new{ not_validate&.include?('phone') }
  validates :email, presence: true, :uniqueness => {:scope=>:user_id}
  validates_length_of :phone, :minimum => 10, :maximum => 13, :allow_nil => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Methods
  # generate uniq token
  def generate_token
    @token = SecureRandom.base58(10)
    self.update(token: @token)
  end

  def full_name
    return nil if first_name.blank? && last_name.blank?
    return first_name if last_name.blank?
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.create_contact(email, user)
    @email = Contact.find_by(email: email)
    if !@email.present?
      @contact = Contact.create!(email: email, user_id: user.id, not_validate: ['first_name', 'last_name', 'phone'])
      Photo.create(user_id: user.id,imageable_type: "Contact",imageable_id: @contact.id)
      return @contact
    else
      return @email
    end
  end
end