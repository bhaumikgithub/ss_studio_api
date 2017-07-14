class Watermark < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user
  has_one :photo, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo

  enum status: { inactive: 0, active: 1 }

  # Validations
 

  # Method

end
