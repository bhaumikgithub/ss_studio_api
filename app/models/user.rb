class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 # Callabcks

 # Associations
  has_many :category

  enum status: { inactive: 0, active: 1 }
  # Validations

   # Scopes

   # Methods
end
