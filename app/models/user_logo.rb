class UserLogo < ApplicationRecord
  belongs_to :user
  has_one :photo, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :photo
end
