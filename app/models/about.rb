class About < ApplicationRecord
  serialize :social_links
  store_accessor :social_links, :facebook_link, :twitter_link, :instagram_link

  # Associations
  has_one :photo, as: :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :photo
end
