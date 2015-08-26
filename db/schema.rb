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

ActiveRecord::Schema.define(version: 20150814172205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "GAME_ID",                   limit: 12
    t.date     "game_date"
    t.integer  "career_hit"
    t.integer  "season_hit"
    t.integer  "game_hit"
    t.string   "AWAY_TEAM_ID",              limit: 3
    t.integer  "INN_CT",                    limit: 2
    t.integer  "BAT_HOME_ID",               limit: 2
    t.integer  "OUTS_CT",                   limit: 2
    t.integer  "BALLS_CT",                  limit: 2
    t.integer  "STRIKES_CT",                limit: 2
    t.string   "PITCH_SEQ_TX",              limit: 40
    t.integer  "AWAY_SCORE_CT",             limit: 2
    t.integer  "HOME_SCORE_CT",             limit: 2
    t.string   "BAT_ID",                    limit: 8
    t.string   "BAT_HAND_CD",               limit: 1
    t.string   "RESP_BAT_ID",               limit: 8
    t.string   "RESP_BAT_HAND_CD",          limit: 1
    t.string   "PIT_ID",                    limit: 8
    t.string   "PIT_HAND_CD",               limit: 1
    t.string   "RESP_PIT_ID",               limit: 8
    t.string   "RESP_PIT_HAND_CD",          limit: 1
    t.string   "POS2_FLD_ID",               limit: 8
    t.string   "POS3_FLD_ID",               limit: 8
    t.string   "POS4_FLD_ID",               limit: 8
    t.string   "POS5_FLD_ID",               limit: 8
    t.string   "POS6_FLD_ID",               limit: 8
    t.string   "POS7_FLD_ID",               limit: 8
    t.string   "POS8_FLD_ID",               limit: 8
    t.string   "POS9_FLD_ID",               limit: 8
    t.string   "BASE1_RUN_ID",              limit: 8
    t.string   "BASE2_RUN_ID",              limit: 8
    t.string   "BASE3_RUN_ID",              limit: 8
    t.string   "EVENT_TX"
    t.string   "LEADOFF_FL",                limit: 1
    t.string   "PH_FL",                     limit: 1
    t.integer  "BAT_FLD_CD",                limit: 2
    t.integer  "BAT_LINEUP_ID",             limit: 2
    t.integer  "EVENT_CD",                  limit: 2
    t.string   "BAT_EVENT_FL",              limit: 1
    t.string   "AB_FL",                     limit: 1
    t.integer  "H_CD",                      limit: 2
    t.string   "SH_FL",                     limit: 1
    t.string   "SF_FL",                     limit: 1
    t.integer  "EVENT_OUTS_CT",             limit: 2
    t.string   "DP_FL",                     limit: 1
    t.string   "TP_FL",                     limit: 1
    t.integer  "RBI_CT",                    limit: 2
    t.string   "WP_FL",                     limit: 1
    t.string   "PB_FL",                     limit: 1
    t.integer  "FLD_CD",                    limit: 2
    t.string   "BATTEDBALL_CD",             limit: 1
    t.string   "BUNT_FL",                   limit: 1
    t.string   "FOUL_FL",                   limit: 1
    t.string   "BATTEDBALL_LOC_TX",         limit: 5
    t.integer  "ERR_CT",                    limit: 2
    t.integer  "ERR1_FLD_CD",               limit: 2
    t.string   "ERR1_CD",                   limit: 1
    t.integer  "ERR2_FLD_CD",               limit: 2
    t.string   "ERR2_CD",                   limit: 1
    t.integer  "ERR3_FLD_CD",               limit: 2
    t.string   "ERR3_CD",                   limit: 1
    t.integer  "BAT_DEST_ID",               limit: 2
    t.integer  "RUN1_DEST_ID",              limit: 2
    t.integer  "RUN2_DEST_ID",              limit: 2
    t.integer  "RUN3_DEST_ID",              limit: 2
    t.string   "BAT_PLAY_TX",               limit: 8
    t.string   "RUN1_PLAY_TX",              limit: 15
    t.string   "RUN2_PLAY_TX",              limit: 15
    t.string   "RUN3_PLAY_TX",              limit: 15
    t.string   "RUN1_SB_FL",                limit: 1
    t.string   "RUN2_SB_FL",                limit: 1
    t.string   "RUN3_SB_FL",                limit: 1
    t.string   "RUN1_CS_FL",                limit: 1
    t.string   "RUN2_CS_FL",                limit: 1
    t.string   "RUN3_CS_FL",                limit: 1
    t.string   "RUN1_PK_FL",                limit: 1
    t.string   "RUN2_PK_FL",                limit: 1
    t.string   "RUN3_PK_FL",                limit: 1
    t.string   "RUN1_RESP_PIT_ID",          limit: 8
    t.string   "RUN2_RESP_PIT_ID",          limit: 8
    t.string   "RUN3_RESP_PIT_ID",          limit: 8
    t.string   "GAME_NEW_FL",               limit: 1
    t.string   "GAME_END_FL",               limit: 1
    t.string   "PR_RUN1_FL",                limit: 1
    t.string   "PR_RUN2_FL",                limit: 1
    t.string   "PR_RUN3_FL",                limit: 1
    t.string   "REMOVED_FOR_PR_RUN1_ID",    limit: 8
    t.string   "REMOVED_FOR_PR_RUN2_ID",    limit: 8
    t.string   "REMOVED_FOR_PR_RUN3_ID",    limit: 8
    t.string   "REMOVED_FOR_PH_BAT_ID",     limit: 8
    t.integer  "REMOVED_FOR_PH_BAT_FLD_CD", limit: 2
    t.integer  "PO1_FLD_CD",                limit: 2
    t.integer  "PO2_FLD_CD",                limit: 2
    t.integer  "PO3_FLD_CD",                limit: 2
    t.integer  "ASS1_FLD_CD",               limit: 2
    t.integer  "ASS2_FLD_CD",               limit: 2
    t.integer  "ASS3_FLD_CD",               limit: 2
    t.integer  "ASS4_FLD_CD",               limit: 2
    t.integer  "ASS5_FLD_CD",               limit: 2
    t.integer  "EVENT_ID"
    t.string   "HOME_TEAM_ID",              limit: 3
    t.string   "BAT_TEAM_ID",               limit: 3
    t.string   "FLD_TEAM_ID",               limit: 3
    t.integer  "BAT_LAST_ID",               limit: 2
    t.string   "INN_NEW_FL",                limit: 1
    t.string   "INN_END_FL",                limit: 1
    t.integer  "START_BAT_SCORE_CT",        limit: 2
    t.integer  "START_FLD_SCORE_CT",        limit: 2
    t.integer  "INN_RUNS_CT",               limit: 2
    t.integer  "GAME_PA_CT"
    t.integer  "INN_PA_CT",                 limit: 2
    t.string   "PA_NEW_FL",                 limit: 1
    t.string   "PA_TRUNC_FL",               limit: 1
    t.integer  "START_BASES_CD",            limit: 2
    t.integer  "END_BASES_CD",              limit: 2
    t.string   "BAT_START_FL",              limit: 1
    t.string   "RESP_BAT_START_FL",         limit: 1
    t.string   "BAT_ON_DECK_ID",            limit: 8
    t.string   "BAT_IN_HOLD_ID",            limit: 8
    t.string   "PIT_START_FL",              limit: 1
    t.string   "RESP_PIT_START_FL",         limit: 1
    t.integer  "RUN1_FLD_CD",               limit: 2
    t.integer  "RUN1_LINEUP_CD",            limit: 2
    t.integer  "RUN1_ORIGIN_EVENT_ID",      limit: 2
    t.integer  "RUN2_FLD_CD",               limit: 2
    t.integer  "RUN2_LINEUP_CD",            limit: 2
    t.integer  "RUN2_ORIGIN_EVENT_ID",      limit: 2
    t.integer  "RUN3_FLD_CD",               limit: 2
    t.integer  "RUN3_LINEUP_CD",            limit: 2
    t.integer  "RUN3_ORIGIN_EVENT_ID",      limit: 2
    t.string   "RUN1_RESP_CAT_ID",          limit: 8
    t.string   "RUN2_RESP_CAT_ID",          limit: 8
    t.string   "RUN3_RESP_CAT_ID",          limit: 8
    t.integer  "PA_BALL_CT",                limit: 2
    t.integer  "PA_CALLED_BALL_CT",         limit: 2
    t.integer  "PA_INTENT_BALL_CT",         limit: 2
    t.integer  "PA_PITCHOUT_BALL_CT",       limit: 2
    t.integer  "PA_HITBATTER_BALL_CT",      limit: 2
    t.integer  "PA_OTHER_BALL_CT",          limit: 2
    t.integer  "PA_STRIKE_CT",              limit: 2
    t.integer  "PA_CALLED_STRIKE_CT",       limit: 2
    t.integer  "PA_SWINGMISS_STRIKE_CT",    limit: 2
    t.integer  "PA_FOUL_STRIKE_CT",         limit: 2
    t.integer  "PA_INPLAY_STRIKE_CT",       limit: 2
    t.integer  "PA_OTHER_STRIKE_CT",        limit: 2
    t.integer  "EVENT_RUNS_CT",             limit: 2
    t.string   "FLD_ID",                    limit: 8
    t.string   "BASE2_FORCE_FL",            limit: 1
    t.string   "BASE3_FORCE_FL",            limit: 1
    t.string   "BASE4_FORCE_FL",            limit: 1
    t.string   "BAT_SAFE_ERR_FL",           limit: 1
    t.integer  "BAT_FATE_ID",               limit: 2
    t.integer  "RUN1_FATE_ID",              limit: 2
    t.integer  "RUN2_FATE_ID",              limit: 2
    t.integer  "RUN3_FATE_ID",              limit: 2
    t.integer  "FATE_RUNS_CT",              limit: 2
    t.integer  "ASS6_FLD_CD",               limit: 2
    t.integer  "ASS7_FLD_CD",               limit: 2
    t.integer  "ASS8_FLD_CD",               limit: 2
    t.integer  "ASS9_FLD_CD",               limit: 2
    t.integer  "ASS10_FLD_CD",              limit: 2
    t.string   "UNKNOWN_OUT_EXC_FL",        limit: 1
    t.string   "UNCERTAIN_PLAY_EXC_FL",     limit: 1
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

end
