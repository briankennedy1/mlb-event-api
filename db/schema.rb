# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151103173355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "game_id",                         limit: 12
    t.date     "game_date"
    t.integer  "batter_career_hit"
    t.integer  "batter_season_hit"
    t.integer  "batter_game_hit"
    t.integer  "batter_career_single"
    t.integer  "batter_season_single"
    t.integer  "batter_game_single"
    t.integer  "batter_career_double"
    t.integer  "batter_season_double"
    t.integer  "batter_game_double"
    t.integer  "batter_career_triple"
    t.integer  "batter_season_triple"
    t.integer  "batter_game_triple"
    t.integer  "batter_career_home_run"
    t.integer  "batter_season_home_run"
    t.integer  "batter_game_home_run"
    t.string   "away_team_id",                    limit: 3
    t.integer  "inn_ct",                          limit: 2
    t.integer  "bat_home_id",                     limit: 2
    t.integer  "outs_ct",                         limit: 2
    t.integer  "balls_ct",                        limit: 2
    t.integer  "strikes_ct",                      limit: 2
    t.string   "pitch_seq_tx",                    limit: 40
    t.integer  "away_score_ct",                   limit: 2
    t.integer  "home_score_ct",                   limit: 2
    t.string   "bat_id",                          limit: 8
    t.string   "bat_hand_cd",                     limit: 1
    t.string   "resp_bat_id",                     limit: 8
    t.string   "resp_bat_hand_cd",                limit: 1
    t.string   "pit_id",                          limit: 8
    t.string   "pit_hand_cd",                     limit: 1
    t.string   "resp_pit_id",                     limit: 8
    t.string   "resp_pit_hand_cd",                limit: 1
    t.string   "pos2_fld_id",                     limit: 8
    t.string   "pos3_fld_id",                     limit: 8
    t.string   "pos4_fld_id",                     limit: 8
    t.string   "pos5_fld_id",                     limit: 8
    t.string   "pos6_fld_id",                     limit: 8
    t.string   "pos7_fld_id",                     limit: 8
    t.string   "pos8_fld_id",                     limit: 8
    t.string   "pos9_fld_id",                     limit: 8
    t.string   "base1_run_id",                    limit: 8
    t.string   "base2_run_id",                    limit: 8
    t.string   "base3_run_id",                    limit: 8
    t.string   "event_tx"
    t.string   "leadoff_fl",                      limit: 1
    t.string   "ph_fl",                           limit: 1
    t.integer  "bat_fld_cd",                      limit: 2
    t.integer  "bat_lineup_id",                   limit: 2
    t.integer  "event_cd",                        limit: 2
    t.string   "bat_event_fl",                    limit: 1
    t.string   "ab_fl",                           limit: 1
    t.integer  "h_cd",                            limit: 2
    t.string   "sh_fl",                           limit: 1
    t.string   "sf_fl",                           limit: 1
    t.integer  "event_outs_ct",                   limit: 2
    t.string   "dp_fl",                           limit: 1
    t.string   "tp_fl",                           limit: 1
    t.integer  "rbi_ct",                          limit: 2
    t.string   "wp_fl",                           limit: 1
    t.string   "pb_fl",                           limit: 1
    t.integer  "fld_cd",                          limit: 2
    t.string   "battedball_cd",                   limit: 1
    t.string   "bunt_fl",                         limit: 1
    t.string   "foul_fl",                         limit: 1
    t.string   "battedball_loc_tx",               limit: 5
    t.integer  "err_ct",                          limit: 2
    t.integer  "err1_fld_cd",                     limit: 2
    t.string   "err1_cd",                         limit: 1
    t.integer  "err2_fld_cd",                     limit: 2
    t.string   "err2_cd",                         limit: 1
    t.integer  "err3_fld_cd",                     limit: 2
    t.string   "err3_cd",                         limit: 1
    t.integer  "bat_dest_id",                     limit: 2
    t.integer  "run1_dest_id",                    limit: 2
    t.integer  "run2_dest_id",                    limit: 2
    t.integer  "run3_dest_id",                    limit: 2
    t.string   "bat_play_tx",                     limit: 15
    t.string   "run1_play_tx",                    limit: 15
    t.string   "run2_play_tx",                    limit: 15
    t.string   "run3_play_tx",                    limit: 15
    t.string   "run1_sb_fl",                      limit: 1
    t.string   "run2_sb_fl",                      limit: 1
    t.string   "run3_sb_fl",                      limit: 1
    t.string   "run1_cs_fl",                      limit: 1
    t.string   "run2_cs_fl",                      limit: 1
    t.string   "run3_cs_fl",                      limit: 1
    t.string   "run1_pk_fl",                      limit: 1
    t.string   "run2_pk_fl",                      limit: 1
    t.string   "run3_pk_fl",                      limit: 1
    t.string   "run1_resp_pit_id",                limit: 8
    t.string   "run2_resp_pit_id",                limit: 8
    t.string   "run3_resp_pit_id",                limit: 8
    t.string   "game_new_fl",                     limit: 1
    t.string   "game_end_fl",                     limit: 1
    t.string   "pr_run1_fl",                      limit: 1
    t.string   "pr_run2_fl",                      limit: 1
    t.string   "pr_run3_fl",                      limit: 1
    t.string   "removed_for_pr_run1_id",          limit: 8
    t.string   "removed_for_pr_run2_id",          limit: 8
    t.string   "removed_for_pr_run3_id",          limit: 8
    t.string   "removed_for_ph_bat_id",           limit: 8
    t.integer  "removed_for_ph_bat_fld_cd",       limit: 2
    t.integer  "po1_fld_cd",                      limit: 2
    t.integer  "po2_fld_cd",                      limit: 2
    t.integer  "po3_fld_cd",                      limit: 2
    t.integer  "ass1_fld_cd",                     limit: 2
    t.integer  "ass2_fld_cd",                     limit: 2
    t.integer  "ass3_fld_cd",                     limit: 2
    t.integer  "ass4_fld_cd",                     limit: 2
    t.integer  "ass5_fld_cd",                     limit: 2
    t.integer  "event_id"
    t.string   "home_team_id",                    limit: 3
    t.string   "bat_team_id",                     limit: 3
    t.string   "fld_team_id",                     limit: 3
    t.integer  "bat_last_id",                     limit: 2
    t.string   "inn_new_fl",                      limit: 1
    t.string   "inn_end_fl",                      limit: 1
    t.integer  "start_bat_score_ct",              limit: 2
    t.integer  "start_fld_score_ct",              limit: 2
    t.integer  "inn_runs_ct",                     limit: 2
    t.integer  "game_pa_ct"
    t.integer  "inn_pa_ct",                       limit: 2
    t.string   "pa_new_fl",                       limit: 1
    t.string   "pa_trunc_fl",                     limit: 1
    t.integer  "start_bases_cd",                  limit: 2
    t.integer  "end_bases_cd",                    limit: 2
    t.string   "bat_start_fl",                    limit: 1
    t.string   "resp_bat_start_fl",               limit: 1
    t.string   "bat_on_deck_id",                  limit: 8
    t.string   "bat_in_hold_id",                  limit: 8
    t.string   "pit_start_fl",                    limit: 1
    t.string   "resp_pit_start_fl",               limit: 1
    t.integer  "run1_fld_cd",                     limit: 2
    t.integer  "run1_lineup_cd",                  limit: 2
    t.integer  "run1_origin_event_id",            limit: 2
    t.integer  "run2_fld_cd",                     limit: 2
    t.integer  "run2_lineup_cd",                  limit: 2
    t.integer  "run2_origin_event_id",            limit: 2
    t.integer  "run3_fld_cd",                     limit: 2
    t.integer  "run3_lineup_cd",                  limit: 2
    t.integer  "run3_origin_event_id",            limit: 2
    t.string   "run1_resp_cat_id",                limit: 8
    t.string   "run2_resp_cat_id",                limit: 8
    t.string   "run3_resp_cat_id",                limit: 8
    t.integer  "pa_ball_ct",                      limit: 2
    t.integer  "pa_called_ball_ct",               limit: 2
    t.integer  "pa_intent_ball_ct",               limit: 2
    t.integer  "pa_pitchout_ball_ct",             limit: 2
    t.integer  "pa_hitbatter_ball_ct",            limit: 2
    t.integer  "pa_other_ball_ct",                limit: 2
    t.integer  "pa_strike_ct",                    limit: 2
    t.integer  "pa_called_strike_ct",             limit: 2
    t.integer  "pa_swingmiss_strike_ct",          limit: 2
    t.integer  "pa_foul_strike_ct",               limit: 2
    t.integer  "pa_inplay_strike_ct",             limit: 2
    t.integer  "pa_other_strike_ct",              limit: 2
    t.integer  "event_runs_ct",                   limit: 2
    t.string   "fld_id",                          limit: 8
    t.string   "base2_force_fl",                  limit: 1
    t.string   "base3_force_fl",                  limit: 1
    t.string   "base4_force_fl",                  limit: 1
    t.string   "bat_safe_err_fl",                 limit: 1
    t.integer  "bat_fate_id",                     limit: 2
    t.integer  "run1_fate_id",                    limit: 2
    t.integer  "run2_fate_id",                    limit: 2
    t.integer  "run3_fate_id",                    limit: 2
    t.integer  "fate_runs_ct",                    limit: 2
    t.integer  "ass6_fld_cd",                     limit: 2
    t.integer  "ass7_fld_cd",                     limit: 2
    t.integer  "ass8_fld_cd",                     limit: 2
    t.integer  "ass9_fld_cd",                     limit: 2
    t.integer  "ass10_fld_cd",                    limit: 2
    t.string   "unknown_out_exc_fl",              limit: 1
    t.string   "uncertain_play_exc_fl",           limit: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "pitcher_game_strikeout"
    t.integer  "pitcher_season_strikeout"
    t.integer  "pitcher_career_strikeout"
    t.integer  "pitcher_game_inning_pitched"
    t.integer  "pitcher_season_inning_pitched"
    t.integer  "pitcher_career_inning_pitched"
    t.integer  "runner1_career_stolen_base"
    t.integer  "runner1_season_stolen_base"
    t.integer  "runner1_game_stolen_base"
    t.integer  "runner2_career_stolen_base"
    t.integer  "runner2_season_stolen_base"
    t.integer  "runner2_game_stolen_base"
    t.integer  "runner3_career_stolen_base"
    t.integer  "runner3_season_stolen_base"
    t.integer  "runner3_game_stolen_base"
    t.integer  "batter_career_sacrifice_fly"
    t.integer  "batter_season_sacrifice_fly"
    t.integer  "batter_game_sacrifice_fly"
    t.integer  "batter_career_sacrifice_hit"
    t.integer  "batter_season_sacrifice_hit"
    t.integer  "batter_game_sacrifice_hit"
    t.integer  "pitcher_career_balk"
    t.integer  "pitcher_season_balk"
    t.integer  "pitcher_game_balk"
    t.integer  "pitcher_career_double"
    t.integer  "pitcher_season_double"
    t.integer  "pitcher_game_double"
    t.integer  "pitcher_career_intentional_walk"
    t.integer  "pitcher_season_intentional_walk"
    t.integer  "pitcher_game_intentional_walk"
    t.integer  "pitcher_career_out"
    t.integer  "pitcher_season_out"
    t.integer  "pitcher_game_out"
    t.integer  "pitcher_career_pick_off"
    t.integer  "pitcher_season_pick_off"
    t.integer  "pitcher_game_pick_off"
    t.integer  "pitcher_career_sacrifice_fly"
    t.integer  "pitcher_season_sacrifice_fly"
    t.integer  "pitcher_game_sacrifice_fly"
    t.integer  "pitcher_career_sacrifice_hit"
    t.integer  "pitcher_season_sacrifice_hit"
    t.integer  "pitcher_game_sacrifice_hit"
    t.integer  "pitcher_career_single"
    t.integer  "pitcher_season_single"
    t.integer  "pitcher_game_single"
    t.integer  "pitcher_career_stolen_base"
    t.integer  "pitcher_season_stolen_base"
    t.integer  "pitcher_game_stolen_base"
    t.integer  "pitcher_career_triple"
    t.integer  "pitcher_season_triple"
    t.integer  "pitcher_game_triple"
    t.integer  "pitcher_career_walk"
    t.integer  "pitcher_season_walk"
    t.integer  "pitcher_game_walk"
    t.integer  "pitcher_career_wild_pitch"
    t.integer  "pitcher_season_wild_pitch"
    t.integer  "pitcher_game_wild_pitch"
    t.integer  "pitcher_career_hit_by_pitch"
    t.integer  "pitcher_season_hit_by_pitch"
    t.integer  "pitcher_game_hit_by_pitch"
    t.integer  "pitcher_career_home_run"
    t.integer  "pitcher_season_home_run"
    t.integer  "pitcher_game_home_run"
    t.integer  "batter_career_walk"
    t.integer  "batter_season_walk"
    t.integer  "batter_game_walk"
    t.integer  "batter_career_intentional_walk"
    t.integer  "batter_season_intentional_walk"
    t.integer  "batter_game_intentional_walk"
    t.integer  "batter_career_hit_by_pitch"
    t.integer  "batter_season_hit_by_pitch"
    t.integer  "batter_game_hit_by_pitch"
    t.integer  "batter_career_fielders_choice"
    t.integer  "batter_season_fielders_choice"
    t.integer  "batter_game_fielders_choice"
    t.integer  "batter_career_rbi"
    t.integer  "batter_season_rbi"
    t.integer  "batter_game_rbi"
    t.integer  "batter_career_run"
    t.integer  "batter_season_run"
    t.integer  "batter_game_run"
  end

  add_index "events", ["ab_fl"], name: "index_events_on_ab_fl", using: :btree
  add_index "events", ["base1_run_id"], name: "index_events_on_base1_run_id", using: :btree
  add_index "events", ["base2_run_id"], name: "index_events_on_base2_run_id", using: :btree
  add_index "events", ["base3_run_id"], name: "index_events_on_base3_run_id", using: :btree
  add_index "events", ["bat_dest_id"], name: "index_events_on_bat_dest_id", using: :btree
  add_index "events", ["bat_id"], name: "index_events_on_bat_id", using: :btree
  add_index "events", ["bat_team_id"], name: "index_events_on_bat_team_id", using: :btree
  add_index "events", ["event_cd"], name: "index_events_on_event_cd", using: :btree
  add_index "events", ["fld_team_id"], name: "index_events_on_fld_team_id", using: :btree
  add_index "events", ["game_date"], name: "index_events_on_game_date", using: :btree
  add_index "events", ["game_end_fl"], name: "index_events_on_game_end_fl", using: :btree
  add_index "events", ["game_id"], name: "index_events_on_game_id", using: :btree
  add_index "events", ["pit_id"], name: "index_events_on_pit_id", using: :btree
  add_index "events", ["rbi_ct"], name: "index_events_on_rbi_ct", using: :btree
  add_index "events", ["resp_pit_id"], name: "index_events_on_resp_pit_id", using: :btree
  add_index "events", ["run1_cs_fl"], name: "index_events_on_run1_cs_fl", using: :btree
  add_index "events", ["run1_dest_id"], name: "index_events_on_run1_dest_id", using: :btree
  add_index "events", ["run1_resp_pit_id"], name: "index_events_on_run1_resp_pit_id", using: :btree
  add_index "events", ["run1_sb_fl"], name: "index_events_on_run1_sb_fl", using: :btree
  add_index "events", ["run2_cs_fl"], name: "index_events_on_run2_cs_fl", using: :btree
  add_index "events", ["run2_dest_id"], name: "index_events_on_run2_dest_id", using: :btree
  add_index "events", ["run2_resp_pit_id"], name: "index_events_on_run2_resp_pit_id", using: :btree
  add_index "events", ["run3_resp_pit_id"], name: "index_events_on_run3_resp_pit_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "player_id"
    t.date     "debut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "full_name"
    t.integer  "debut_year"
  end

end
