class AddVideoThumbInVideo < ActiveRecord::Migration[5.0]
  def change
  	add_column :videos, :video_thumb, :string
  end
end
