class Testimonial < ApplicationRecord
  acts_as_paranoid

  # Callabcks

  # Associations

  # Associations
  belongs_to :contact
  belongs_to :user
  has_one :photo, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo, reject_if: proc { |attributes| attributes['image'].blank? }
  # Enumerator

  # Validations
  validates :client_name, :message, :photo, presence: true
  validates :rating, :numericality => {:greater_than => 0}
end
