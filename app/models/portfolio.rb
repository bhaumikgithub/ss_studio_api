class Portfolio < ApplicationRecord
  belongs_to :user

  validates_inclusion_of :gallery_column, :in => 1..4, message: 'must be between 1 to 4'
end
