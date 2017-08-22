class RemoveYoutubeAndVimeoUrlFromVideo < ActiveRecord::Migration[5.0]
  def change
  	remove_column :videos, :is_youtube_url
  	remove_column :videos, :is_vimeo_url
  end
end
