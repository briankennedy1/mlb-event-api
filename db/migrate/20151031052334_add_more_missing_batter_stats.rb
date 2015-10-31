class AddMoreMissingBatterStats < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_hit_by_pitch, :integer
    add_column :events, :batter_season_hit_by_pitch, :integer
    add_column :events, :batter_game_hit_by_pitch, :integer
    add_column :events, :batter_career_fielders_choice, :integer
    add_column :events, :batter_season_fielders_choice, :integer
    add_column :events, :batter_game_fielders_choice, :integer
  end
end
