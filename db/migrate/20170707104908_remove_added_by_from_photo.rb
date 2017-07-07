class RemoveAddedByFromPhoto < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :added_by, :string
  end
end
