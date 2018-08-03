class AddPositionToVideos < ActiveRecord::Migration[5.0]
  def change
  	add_column :videos, :position, :integer, :default => 0
  end
end
