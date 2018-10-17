class AddStartPlanDateAndEndPlanDateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :start_plan_date, :date
    add_column :users, :end_plan_date, :date
  end
end
