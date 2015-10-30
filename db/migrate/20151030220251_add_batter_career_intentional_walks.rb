class AddBatterCareerIntentionalWalks < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_intentional_walk, :integer
    add_column :events, :batter_season_intentional_walk, :integer
    add_column :events, :batter_game_intentional_walk, :integer
  end
end
