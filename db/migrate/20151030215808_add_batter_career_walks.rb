class AddBatterCareerWalks < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_walk, :integer
    add_column :events, :batter_season_walk, :integer
    add_column :events, :batter_game_walk, :integer
  end
end
