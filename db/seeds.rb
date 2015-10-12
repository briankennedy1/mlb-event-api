require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_sbs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.base1_run_id = '#{player}' AND events.run1_sb_fl = 'T'
    OR events.base2_run_id = '#{player}' AND events.run2_sb_fl = 'T'
    OR events.base3_run_id = '#{player}' AND events.run3_sb_fl = 'T'
    ")
  all_sbs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_sbs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_sbs.each do |current_event|
    season_group = all_sbs.select do |sb|
      sb.game_date.year == current_event.game_date.year
    end

    game_group = all_sbs.select do |sb|
      sb.game_id == current_event.game_id
    end

    if player == current_event.base1_run_id
      current_event.update_columns(
        runner1_career_stolen_base: all_sbs
          .index(current_event) + 1,
        runner1_season_stolen_base:
          season_group.index(current_event) + 1,
        runner1_game_stolen_base:
          game_group.index(current_event) + 1
      )
    elsif player == current_event.base2_run_id
      current_event.update_columns(
        runner2_career_stolen_base: all_sbs
          .index(current_event) + 1,
        runner2_season_stolen_base:
          season_group.index(current_event) + 1,
        runner2_game_stolen_base:
          game_group.index(current_event) + 1
      )
    elsif player == current_event.base3_run_id
      current_event.update_columns(
        runner3_career_stolen_base: all_sbs
          .index(current_event) + 1,
        runner3_season_stolen_base:
          season_group.index(current_event) + 1,
        runner3_game_stolen_base:
          game_group.index(current_event) + 1
      )
    pbar.increment
  end
end
