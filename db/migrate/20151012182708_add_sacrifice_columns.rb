class AddSacrificeColumns < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_sacrifice_fly, :integer
    add_column :events, :batter_season_sacrifice_fly, :integer
    add_column :events, :batter_game_sacrifice_fly, :integer
    add_column :events, :batter_career_sacrifice_hit, :integer
    add_column :events, :batter_season_sacrifice_hit, :integer
    add_column :events, :batter_game_sacrifice_hit, :integer
  end
end
