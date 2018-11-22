class RemovePlanDateFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :start_plan_date, :date
    remove_column :users, :end_plan_date, :date
  end
end