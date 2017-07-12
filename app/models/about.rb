class About < ApplicationRecord
	serialize :social_links, HashSerializer
  store_accessor :social_links, :facebook_link, :twitter_link, :instagram_link
end
