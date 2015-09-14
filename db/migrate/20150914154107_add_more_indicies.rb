class AddMoreIndicies < ActiveRecord::Migration
  def change
    add_index :events, :bat_team_id
    add_index :events, :game_end_fl
    add_index :events, :year
    add_index :events, :fld_team_id
  end
end
