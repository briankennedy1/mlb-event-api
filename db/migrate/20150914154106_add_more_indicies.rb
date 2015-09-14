class AddMoreIndicies < ActiveRecord::Migration
  def change
    add_index :events, :pit_id
    add_index :events, :resp_pit_id
    add_index :events, :ab_fl
    add_index :events, :sh_fl
    add_index :events, :sf_fl
    add_index :events, :rbi_ct
    add_index :events, :base1_run_id
    add_index :events, :base2_run_id
    add_index :events, :base3_run_id
    add_index :events, :run1_sb_fl
    add_index :events, :run2_sb_fl
    add_index :events, :run3_sb_fl
    add_index :events, :run1_cs_fl
    add_index :events, :run2_cs_fl
    add_index :events, :run3_cs_fl
    add_index :events, :bat_dest_id
    add_index :events, :run1_dest_id
    add_index :events, :run2_dest_id
    add_index :events, :run3_dest_id
    add_index :events, :wp_fl
    add_index :events, :run1_resp_pit_id
    add_index :events, :run2_resp_pit_id
    add_index :events, :run3_resp_pit_id
  end
end
