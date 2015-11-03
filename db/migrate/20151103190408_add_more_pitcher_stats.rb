class AddMorePitcherStats < ActiveRecord::Migration
  def change
    add_column :events, :pitcher_career_earned_run, :integer
    add_column :events, :pitcher_season_earned_run, :integer
    add_column :events, :pitcher_game_earned_run, :integer
    add_column :events, :pitcher_career_allowed_run, :integer
    add_column :events, :pitcher_season_allowed_run, :integer
    add_column :events, :pitcher_game_allowed_run, :integer
  end
end
