class AddSacrificesColumn < ActiveRecord::Migration
  def change
    add_column :events, :batter_career_sacrifice, :integer
    add_column :events, :batter_season_sacrifice, :integer
    add_column :events, :batter_game_sacrifice, :integer
  end
end
