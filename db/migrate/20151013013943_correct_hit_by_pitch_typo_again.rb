class CorrectHitByPitchTypoAgain < ActiveRecord::Migration
  def change
    remove_column :events, :pitcher_career_hit_by_pitcher, :integer
    remove_column :events, :pitcher_season_hit_by_pitcher, :integer
    remove_column :events, :pitcher_game_hit_by_pitcher, :integer
    add_column :events, :pitcher_career_hit_by_pitch, :integer
    add_column :events, :pitcher_season_hit_by_pitch, :integer
    add_column :events, :pitcher_game_hit_by_pitch, :integer
  end
end
