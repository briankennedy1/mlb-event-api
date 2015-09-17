require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_singles = Event.where(
    bat_id: player,
    # event_cd: [20, 21, 22, 23]
    event_cd: 20)
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_singles.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_singles.each do |current_event|
    current_event.update_columns(
      career_single: all_singles
        .index(current_event) + 1,
      season_single: all_singles
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      game_single: all_singles
        .by_day(current_event.game_date)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
