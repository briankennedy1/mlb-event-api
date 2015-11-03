class AddBatterRuns < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_run, :integer
    add_column :events, :batter_season_run, :integer
    add_column :events, :batter_game_run, :integer
  end
end
