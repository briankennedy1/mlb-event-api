class DropPitcherRunColumns < ActiveRecord::Migration
  def change
    remove_column :events, :pitcher_career_earned_run
    remove_column :events, :pitcher_season_earned_run
    remove_column :events, :pitcher_game_earned_run
    remove_column :events, :pitcher_career_allowed_run
    remove_column :events, :pitcher_season_allowed_run
    remove_column :events, :pitcher_game_allowed_run
  end
end
