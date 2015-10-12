class RemoveSbColumn < ActiveRecord::Migration
  def change
    remove_column :events, :runner_career_stolen_base
    remove_column :events, :runner_season_stolen_base
    remove_column :events, :runner_game_stolen_base
  end
end
