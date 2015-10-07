class AddRunnerStolenBaseMilestones < ActiveRecord::Migration
  def change
    add_column :events, :runner_career_stolen_base, :integer
    add_column :events, :runner_season_stolen_base, :integer
    add_column :events, :runner_game_stolen_base, :integer
  end
end
