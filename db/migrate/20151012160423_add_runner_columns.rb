class AddRunnerColumns < ActiveRecord::Migration
  def change
    add_column :events, :runner1_career_stolen_base, :integer
    add_column :events, :runner1_season_stolen_base, :integer
    add_column :events, :runner1_game_stolen_base, :integer
    add_column :events, :runner2_career_stolen_base, :integer
    add_column :events, :runner2_season_stolen_base, :integer
    add_column :events, :runner2_game_stolen_base, :integer
    add_column :events, :runner3_career_stolen_base, :integer
    add_column :events, :runner3_season_stolen_base, :integer
    add_column :events, :runner3_game_stolen_base, :integer
  end
end
