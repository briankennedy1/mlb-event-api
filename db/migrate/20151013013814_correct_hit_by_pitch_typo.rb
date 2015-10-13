class CorrectHitByPitchTypo < ActiveRecord::Migration
  def change
    remove_column :events, :pitcher_career_hit_by_pitche, :integer
    remove_column :events, :pitcher_season_hit_by_pitche, :integer
    remove_column :events, :pitcher_game_hit_by_pitche, :integer
    add_column :events, :pitcher_career_hit_by_pitcher, :integer
    add_column :events, :pitcher_season_hit_by_pitcher, :integer
    add_column :events, :pitcher_game_hit_by_pitcher, :integer
  end
end
