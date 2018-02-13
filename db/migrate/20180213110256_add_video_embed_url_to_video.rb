class AddVideoEmbedUrlToVideo < ActiveRecord::Migration[5.0]
  def change
  	add_column :videos, :video_embed_url, :string
  end
end
