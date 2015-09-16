require 'csv'
require 'ruby-progressbar'
require 'smarter_csv'
require 'parallel'
require 'players'

all_homers = Event.where(
  bat_id: 'adamj901',
  # event_cd: [20, 21, 22, 23]
  event_cd: 23
).order(:game_date, :id)

pbar = ProgressBar.create(
  starting_at: 0,
  total: all_homers.count,
  format: '%a %e %P% Processed: %c from %C'
)

all_homers.each do |current_event|
  current_event.update_columns(
  career_home_run: current_event.event_cd == 23 ?
    all_homers.index(current_event) + 1 : nil,
  season_home_run: current_event.event_cd == 23 ?
    all_homers.by_year(current_event.game_date.year).index(current_event) + 1 : nil,
  game_home_run: current_event.event_cd == 23 ?
    all_homers.by_day(current_event.game_date).index(current_event) + 1 : nil
  )
  pbar.increment
end
