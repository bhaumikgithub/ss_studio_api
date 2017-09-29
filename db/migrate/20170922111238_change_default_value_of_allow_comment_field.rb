class ChangeDefaultValueOfAllowCommentField < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :album_recipients, :allow_comments, false
  end
end
