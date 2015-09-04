class AddFirstIndicies < ActiveRecord::Migration
  def change
    add_index :events, :bat_id
    add_index :events, :event_cd
  end
end
