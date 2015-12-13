class AddCreatorRefToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :creator, index: true, foreign_key: true, unique: true
  end
end
