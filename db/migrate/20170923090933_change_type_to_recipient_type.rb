class ChangeTypeToRecipientType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :album_recipients, :type, :recipient_type
  end
end
