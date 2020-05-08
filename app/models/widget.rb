class Widget < ApplicationRecord
  belongs_to :user
  validates_presence_of :code, :if => lambda { self.is_active? }
end
