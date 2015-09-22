class RenameBattingColumns < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :career_hit, :batter_career_hit
      t.rename :season_hit, :batter_season_hit
      t.rename :game_hit, :batter_game_hit
      t.rename :career_single, :batter_career_single
      t.rename :season_single, :batter_season_single
      t.rename :game_single, :batter_game_single
      t.rename :career_double, :batter_career_double
      t.rename :season_double, :batter_season_double
      t.rename :game_double, :batter_game_double
      t.rename :career_triple, :batter_career_triple
      t.rename :season_triple, :batter_season_triple
      t.rename :game_triple, :batter_game_triple
      t.rename :career_home_run, :batter_career_home_run
      t.rename :season_home_run, :batter_season_home_run
      t.rename :game_home_run, :batter_game_home_run
    end
  end
end
