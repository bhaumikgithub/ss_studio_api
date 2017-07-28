class AddIndexForSocialLink < ActiveRecord::Migration[5.0]
  def change
  	add_index  :abouts, :social_links, using: :gin
  end
end
