class AddRunnerRunsAgain < ActiveRecord::Migration
  def change
    add_column :events, :runner1_career_run, :integer
    add_column :events, :runner1_season_run, :integer
    add_column :events, :runner1_game_run, :integer
    add_column :events, :runner2_career_run, :integer
    add_column :events, :runner2_season_run, :integer
    add_column :events, :runner2_game_run, :integer
    add_column :events, :runner3_career_run, :integer
    add_column :events, :runner3_season_run, :integer
    add_column :events, :runner3_game_run, :integer
  end
end
