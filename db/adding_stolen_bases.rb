require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  run1_sb = Event.where(
    base1_run_id: player,
    run1_sb_fl: 'T'
  )
  run2_sb = Event.where(
    base2_run_id: player,
    run2_sb_fl: 'T'
  )
  run3_sb = Event.where(
    base3_run_id: player,
    run3_sb_fl: 'T'
  )
  all_sbs = run1_sb + run2_sb + run3_sb
  all_sbs.sort! { |x, y| x.game_date <=> y.game_date }

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_sbs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_sbs.each do |current_event|
    current_event.update_columns(
      runner_career_stolen_base: all_sbs
        .index(current_event) + 1,
      runner_season_stolen_base: all_sbs
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      runner_game_stolen_base: all_sbs
        .where(game_id: current_event.game_id)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
