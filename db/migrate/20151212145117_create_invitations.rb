class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :attendee_id
    end
    add_index :invitations, :event_id
    add_index :invitations, :attendee_id
  end
end
