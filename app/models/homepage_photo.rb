class HomepagePhoto < ApplicationRecord
  belongs_to :user
  has_many :photos, as: :imageable, dependent: :destroy
  
end
