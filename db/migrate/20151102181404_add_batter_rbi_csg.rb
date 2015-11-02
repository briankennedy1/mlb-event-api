class AddBatterRbiCsg < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_rbi, :integer
    add_column :events, :batter_season_rbi, :integer
    add_column :events, :batter_game_rbi, :integer
  end
end
