require 'csv'
require 'ruby-progressbar'
require 'smarter_csv'
require 'parallel'
require_relative 'players'



PLAYERS.each do |player|

  all_doubles = Event.where(
    bat_id: player,
    # event_cd: [20, 21, 22, 23]
    event_cd: 21
  ).order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_doubles.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_doubles.each do |current_event|
    current_event.update_columns(
    career_double: current_event.event_cd == 22 ?
      all_doubles.index(current_event) + 1 : nil,
    season_double: current_event.event_cd == 22 ?
      all_doubles.by_year(current_event.game_date.year).index(current_event) + 1 : nil,
    game_double: current_event.event_cd == 22 ?
      all_doubles.by_day(current_event.game_date).index(current_event) + 1 : nil
    )
    pbar.increment
  end
end
