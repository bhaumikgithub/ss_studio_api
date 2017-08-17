class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
 # Callabcks

 # Associations
  has_many :contacts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :watermarks, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :contact_details, dependent: :destroy 
  has_many :videos, dependent: :destroy
  has_many :homepage_photos, dependent: :destroy 
  has_many :testimonials, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  # Validations

  # Scopes

  # Methods
  def full_name
    return nil if first_name.blank? && last_name.blank?
    return first_name if last_name.blank?
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
