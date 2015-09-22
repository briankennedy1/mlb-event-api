class AddPitchingMilestoneColumns < ActiveRecord::Migration
  def change
    add_column :events, :pitcher_game_strikeout, :integer
    add_column :events, :pitcher_season_strikeout, :integer
    add_column :events, :pitcher_career_strikeout, :integer
    add_column :events, :pitcher_game_inning_pitched, :integer
    add_column :events, :pitcher_season_inning_pitched, :integer
    add_column :events, :pitcher_career_inning_pitched, :integer
  end
end
