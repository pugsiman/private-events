class ChangeEventsDate < ActiveRecord::Migration
  def change
    change_column :events, :date, 'date USING CAST(date AS date)'
  end
end
