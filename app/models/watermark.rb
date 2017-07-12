class Watermark < ApplicationRecord
  acts_as_paranoid
  # Callabcks

  # Associations
  belongs_to :user

  enum status: { inactive: 0, active: 1 }

  # Validations
 

  # Method

end
