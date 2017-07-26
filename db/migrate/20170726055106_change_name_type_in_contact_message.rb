class ChangeNameTypeInContactMessage < ActiveRecord::Migration[5.0]
  def change
  	change_column :contact_messages, :name, :string
  	change_column :contact_messages, :message, :text
  end
end
