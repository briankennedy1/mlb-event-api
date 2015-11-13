class AddPitcherHitsColumn < ActiveRecord::Migration
  def change
    add_column :events, :pitcher_career_hit, :integer
    add_column :events, :pitcher_season_hit, :integer
    add_column :events, :pitcher_game_hit, :integer
  end
end
