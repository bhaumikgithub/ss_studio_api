class AddUserToAbouts < ActiveRecord::Migration[5.0]
  def change
    add_reference :abouts, :user, foreign_key: true
  end
end
