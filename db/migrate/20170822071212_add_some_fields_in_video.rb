class AddSomeFieldsInVideo < ActiveRecord::Migration[5.0]
  def change
  	add_column :videos, :title, :string
  	add_column :videos, :type, :integer
  	add_column :videos, :video_url, :string
  	add_column :videos, :status, :integer
  end
end
