class DropIndicies < ActiveRecord::Migration
  def change
    remove_index :events, :run3_resp_pit_id
  end
end
