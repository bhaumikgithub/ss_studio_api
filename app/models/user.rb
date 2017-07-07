class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
 # Callabcks

 # Associations
  has_many :category, dependent: :destroy
  has_many :watermarks, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy

  enum status: { inactive: 0, active: 1 }
  # Validations

   # Scopes

   # Methods
end
