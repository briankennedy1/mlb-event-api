class CorrectHomeRunTypo < ActiveRecord::Migration
  def change
    remove_column :events, :pitcher_career_homer, :integer
    remove_column :events, :pitcher_season_homer, :integer
    remove_column :events, :pitcher_game_homer, :integer
    add_column :events, :pitcher_career_home_run, :integer
    add_column :events, :pitcher_season_home_run, :integer
    add_column :events, :pitcher_game_home_run, :integer
  end
end
