require 'csv'
require 'ruby-progressbar'
require 'smarter_csv'
require 'parallel'

all_hits = Event.where(
  # bat_id: 'troum001',
  # event_cd: [20, 21, 22, 23]
  event_cd: 23
).order(:game_date, :id)

pbar = ProgressBar.create(
  starting_at: 0,
  total: all_hits.count,
  format: '%a %e %P% Processed: %c from %C'
)

Parallel.each(all_hits) do |current_event|
  ActiveRecord::Base.connection.reconnect!
    current_event.update_columns(
    career_home_run: current_event.event_cd == 23 ?
      all_hits.where(
        bat_id: current_event.bat_id,
        event_cd: 23
        ).index(current_event) + 1 : nil,
    season_home_run: current_event.event_cd == 23 ?
      all_hits.by_year(current_event.game_date.year).where(
        bat_id: current_event.bat_id,
        event_cd: 23
        ).index(current_event) + 1 : nil,
    game_home_run: current_event.event_cd == 23 ?
      all_hits.by_day(current_event.game_date).where(
        bat_id: current_event.bat_id,
        event_cd: 23
        ).index(current_event) + 1 : nil
    )
end
