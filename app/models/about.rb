class About < ApplicationRecord
  serialize :social_links
  store_accessor :social_links, :facebook_link, :twitter_link, :instagram_link, :youtube_link, :vimeo_link,:linkedin_link, :pinterest_link, :flickr_link

  # Associations
  has_one :photo, as: :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :photo

  # Validations
  validates :title_text, :description, presence: true

end
