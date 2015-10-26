class AddIndexForRun3RespPit < ActiveRecord::Migration
  def change
    add_index :events, :run3_resp_pit_id
  end
end
