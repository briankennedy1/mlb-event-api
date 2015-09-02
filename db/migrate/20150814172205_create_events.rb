class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :seq_events
      t.integer :year_id
      t.string :game_id, :limit => 12
      t.date :game_date
      t.integer :career_hit
      t.integer :season_hit
      t.integer :game_hit
      t.integer :career_single
      t.integer :season_single
      t.integer :game_single
      t.integer :career_double
      t.integer :season_double
      t.integer :game_double
      t.integer :career_triple
      t.integer :season_triple
      t.integer :game_triple
      t.integer :career_home_run
      t.integer :season_home_run
      t.integer :game_home_run
      t.string :away_team_id, :limit => 3
      t.integer :inn_ct, :limit => 2
      t.integer :bat_home_id, :limit => 1
      t.integer :outs_ct, :limit => 1
      t.integer :balls_ct, :limit => 1
      t.integer :strikes_ct, :limit => 1
      t.string :pitch_seq_tx, :limit => 40
      t.integer :away_score_ct, :limit => 2
      t.integer :home_score_ct, :limit => 2
      t.string :bat_id, :limit => 8
      t.string :bat_hand_cd, :limit => 1
      t.string :resp_bat_id, :limit => 8
      t.string :resp_bat_hand_cd, :limit => 1
      t.string :pit_id, :limit => 8
      t.string :pit_hand_cd, :limit => 1
      t.string :res_pit_id, :limit => 8
      t.string :res_pit_hand_cd, :limit => 1
      t.string :pos2_fld_id, :limit => 8
      t.string :pos3_fld_id, :limit => 8
      t.string :pos4_fld_id, :limit => 8
      t.string :pos5_fld_id, :limit => 8
      t.string :pos6_fld_id, :limit => 8
      t.string :pos7_fld_id, :limit => 8
      t.string :pos8_fld_id, :limit => 8
      t.string :pos9_fld_id, :limit => 8
      t.string :base1_run_id, :limit => 8
      t.string :base2_run_id, :limit => 8
      t.string :base3_run_id, :limit => 8
      t.string :event_tx
      t.string :leadoff_fl, :limit => 1
      t.string :ph_fl, :limit => 1
      t.integer :bat_fld_cd, :limit => 1
      t.integer :bat_lineup_id, :limit => 2
      t.integer :event_cd, :limit => 2
      t.string :bat_event_fl, :limit => 1
      t.string :ab_fl, :limit => 1
      t.integer :h_cd, :limit => 1
      t.string :sh_fl, :limit => 1
      t.string :sf_fl, :limit => 1
      t.integer :event_outs_ct, :limit => 1
      t.string :dp_fl, :limit => 1
      t.string :tp_fl, :limit => 1
      t.integer :rbi_ct, :limit => 1
      t.string :wp_fl, :limit => 1
      t.string :pb_fl, :limit => 1
      t.integer :fld_cd, :limit => 2
      t.string :battedball_cd, :limit => 1
      t.string :bunt_fl, :limit => 1
      t.string :foul_fl, :limit => 1
      t.string :battedball_loc_tx, :limit => 5
      t.integer :err_ct, :limit => 1
      t.integer :err1_fld_cd, :limit => 2
      t.string :err1_cd, :limit => 1
      t.integer :err2_fld_cd, :limit => 2
      t.string :err2_cd, :limit => 1
      t.integer :err3_fld_cd, :limit => 2
      t.string :err3_cd, :limit => 1
      t.integer :bat_dest_id, :limit => 1
      t.integer :run1_dest_id, :limit => 1
      t.integer :run2_dest_id, :limit => 1
      t.integer :run3_dest_id, :limit => 1
      t.string :bat_play_tx, :limit => 15
      t.string :run1_play_tx, :limit => 15
      t.string :run2_play_tx, :limit => 15
      t.string :run3_play_tx, :limit => 15
      t.string :run1_sb_fl, :limit => 1
      t.string :run2_sb_fl, :limit => 1
      t.string :run3_sb_fl, :limit => 1
      t.string :run1_cs_fl, :limit => 1
      t.string :run2_cs_fl, :limit => 1
      t.string :run3_cs_fl, :limit => 1
      t.string :run1_pk_fl, :limit => 1
      t.string :run2_pk_fl, :limit => 1
      t.string :run3_pk_fl, :limit => 1
      t.string :run1_resp_pit_id, :limit => 8
      t.string :run2_resp_pit_id, :limit => 8
      t.string :run3_resp_pit_id, :limit => 8
      t.string :game_new_fl, :limit => 1
      t.string :game_end_fl, :limit => 1
      t.string :pr_run1_fl, :limit => 1
      t.string :pr_run2_fl, :limit => 1
      t.string :pr_run3_fl, :limit => 1
      t.string :removed_for_pr_run1_id, :limit => 8
      t.string :removed_for_pr_run2_id, :limit => 8
      t.string :removed_for_pr_run3_id, :limit => 8
      t.string :removed_for_ph_bat_id, :limit => 8
      t.integer :removed_for_ph_bat_fld_cd, :limit => 2
      t.integer :po1_fld_cd, :limit => 2
      t.integer :po2_fld_cd, :limit => 2
      t.integer :po3_fld_cd, :limit => 2
      t.integer :ass1_fld_cd, :limit => 2
      t.integer :ass2_fld_cd, :limit => 2
      t.integer :ass3_fld_cd, :limit => 2
      t.integer :ass4_fld_cd, :limit => 2
      t.integer :ass5_fld_cd, :limit => 2
      t.integer :event_id, :limit => 3
      t.string :home_team_id, :limit => 3
      t.string :bat_team_id, :limit => 3
      t.string :fld_team_id, :limit => 3
      t.integer :bat_last_id, :limit => 1
      t.string :inn_new_fl, :limit => 1
      t.string :inn_end_fl, :limit => 1
      t.integer :start_bat_score_ct, :limit => 2
      t.integer :start_fld_score_ct, :limit => 2
      t.integer :inn_runs_ct, :limit => 2
      t.integer :game_pa_ct, :limit => 3
      t.integer :inn_pa_ct, :limit => 2
      t.string :pa_new_fl, :limit => 1
      t.string :pa_trunc_fl, :limit => 1
      t.integer :start_bases_cd, :limit => 1
      t.integer :end_bases_cd, :limit => 1
      t.string :bat_start_fl, :limit => 1
      t.string :resp_bat_start_fl, :limit => 1
      t.string :bat_on_deck_id, :limit => 8
      t.string :bat_in_hold_id, :limit => 8
      t.string :pit_start_fl, :limit => 1
      t.string :resp_pit_start_fl, :limit => 1
      t.integer :run1_fld_cd, :limit => 2
      t.integer :run1_lineup_cd, :limit => 2
      t.integer :run1_origin_event_id, :limit => 2
      t.integer :run2_fld_cd, :limit => 2
      t.integer :run2_lineup_cd, :limit => 2
      t.integer :run2_origin_event_id, :limit => 2
      t.integer :run3_fld_cd, :limit => 2
      t.integer :run3_lineup_cd, :limit => 2
      t.integer :run3_origin_event_id, :limit => 2
      t.string :run1_resp_cat_id, :limit => 8
      t.string :run2_resp_cat_id, :limit => 8
      t.string :run3_resp_cat_id, :limit => 8
      t.integer :pa_ball_ct, :limit => 1
      t.integer :pa_called_ball_ct, :limit => 1
      t.integer :pa_intent_ball_ct, :limit => 1
      t.integer :pa_pitchout_ball_ct, :limit => 1
      t.integer :pa_hitbatter_ball_ct, :limit => 1
      t.integer :pa_other_ball_ct, :limit => 1
      t.integer :pa_strike_ct, :limit => 1
      t.integer :pa_called_strike_ct, :limit => 1
      t.integer :pa_swingmiss_strike_ct, :limit => 1
      t.integer :pa_foul_strike_ct, :limit => 1
      t.integer :pa_inplay_strike_ct, :limit => 1
      t.integer :pa_other_strike_ct, :limit => 1
      t.integer :event_runs_ct, :limit => 1
      t.string :fld_id, :limit => 8
      t.string :base2_force_fl, :limit => 1
      t.string :base3_force_fl, :limit => 1
      t.string :base4_force_fl, :limit => 1
      t.string :bat_safe_err_fl, :limit => 1
      t.integer :bat_fate_id, :limit => 1
      t.integer :run1_fate_id, :limit => 1
      t.integer :run2_fate_id, :limit => 1
      t.integer :run3_fate_id, :limit => 1
      t.integer :fate_runs_ct, :limit => 1
      t.integer :ass6_fld_cd, :limit => 1
      t.integer :ass7_fld_cd, :limit => 1
      t.integer :ass8_fld_cd, :limit => 1
      t.integer :ass9_fld_cd, :limit => 1
      t.integer :ass10_fld_cd, :limit => 1
      t.string :unknown_out_exc_fl, :limit => 1
      t.string :uncertain_play_exc_fl, :limit => 1

      t.timestamps null: false
    end
  end
end
