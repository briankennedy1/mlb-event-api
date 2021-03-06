class AddMajorityOfPitcherColumns < ActiveRecord::Migration
  def change
    add_column :events, :pitcher_career_balk, :integer
    add_column :events, :pitcher_season_balk, :integer
    add_column :events, :pitcher_game_balk, :integer
    add_column :events, :pitcher_career_double, :integer
    add_column :events, :pitcher_season_double, :integer
    add_column :events, :pitcher_game_double, :integer
    add_column :events, :pitcher_career_hit_by_pitche, :integer
    add_column :events, :pitcher_season_hit_by_pitche, :integer
    add_column :events, :pitcher_game_hit_by_pitche, :integer
    add_column :events, :pitcher_career_homer, :integer
    add_column :events, :pitcher_season_homer, :integer
    add_column :events, :pitcher_game_homer, :integer
    add_column :events, :pitcher_career_intentional_walk, :integer
    add_column :events, :pitcher_season_intentional_walk, :integer
    add_column :events, :pitcher_game_intentional_walk, :integer
    add_column :events, :pitcher_career_out, :integer
    add_column :events, :pitcher_season_out, :integer
    add_column :events, :pitcher_game_out, :integer
    add_column :events, :pitcher_career_pick_off, :integer
    add_column :events, :pitcher_season_pick_off, :integer
    add_column :events, :pitcher_game_pick_off, :integer
    add_column :events, :pitcher_career_sacrifice_fly, :integer
    add_column :events, :pitcher_season_sacrifice_fly, :integer
    add_column :events, :pitcher_game_sacrifice_fly, :integer
    add_column :events, :pitcher_career_sacrifice_hit, :integer
    add_column :events, :pitcher_season_sacrifice_hit, :integer
    add_column :events, :pitcher_game_sacrifice_hit, :integer
    add_column :events, :pitcher_career_single, :integer
    add_column :events, :pitcher_season_single, :integer
    add_column :events, :pitcher_game_single, :integer
    add_column :events, :pitcher_career_stolen_base, :integer
    add_column :events, :pitcher_season_stolen_base, :integer
    add_column :events, :pitcher_game_stolen_base, :integer
    add_column :events, :pitcher_career_triple, :integer
    add_column :events, :pitcher_season_triple, :integer
    add_column :events, :pitcher_game_triple, :integer
    add_column :events, :pitcher_career_walk, :integer
    add_column :events, :pitcher_season_walk, :integer
    add_column :events, :pitcher_game_walk, :integer
    add_column :events, :pitcher_career_wild_pitch, :integer
    add_column :events, :pitcher_season_wild_pitch, :integer
    add_column :events, :pitcher_game_wild_pitch, :integer
  end
end
