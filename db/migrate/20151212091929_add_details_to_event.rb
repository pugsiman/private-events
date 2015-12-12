class AddDetailsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :text
    add_column :events, :title, :string
    add_column :events, :location, :string
    add_column :events, :time, :time
  end
end
