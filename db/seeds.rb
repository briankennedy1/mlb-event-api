# Order all events by game date
# Find every event with a hit
# Add game/season/career hits
puts '~~~~~~~~~~~~~~~~~'
puts '~~ Adding hits ~~'
puts '~~~~~~~~~~~~~~~~~'
# throw in bondb001 to test it on the first run
all_hits = Event.where(
  # bat_id: 'troum001',
  # event_cd: [20, 21, 22, 23]
  event_cd: 23
).order(:game_date, :id)

progressbar = ProgressBar.create(
  starting_at: 0,
  total: all_hits.count,
  format: "%a %e %P% Processed: %c from %C"
)

all_hits.each_slice(100) do |batch|
  batch.each do |current_event|
    current_event.update_columns(

      # career_cycle:
      # if game_single >= 1
      # && game_double >= 1
      # && game_triple >= 1
      # && game_home_run == 0
      # && event_cd == 23
      # it's a cycle
      # cycle_fl = 'T'

      # elsif game_single == 0
      # && game_double >= 1
      # && game_triple >= 1
      # && game_home_run >= 1
      # && event_cd == 20
      # it's a cycle
      # cycle_fl = 'T'

      # elsif game_single >= 1
      # && game_double == 0
      # && game_triple >= 1
      # && game_home_run >= 1
      # && event_cd == 21
      # it's a cycle
      # cycle_fl = 'T'

      # elsif game_single >= 1
      # && game_double >= 1
      # && game_triple == 0
      # && game_home_run >= 1
      # && event_cd == 22
      # it's a cycle
      # cycle_fl = 'T'

      # career_cycle:
      #   all_hits.where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,
      # season_cycle:
      #   all_hits.by_year(current_event.game_date.year).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,
      # game_cycle:
      #   all_hits.by_day(current_event.game_date).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,

      # career_hit:
      #   all_hits.where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,
      # season_hit:
      #   all_hits.by_year(current_event.game_date.year).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,
      # game_hit:
      #   all_hits.by_day(current_event.game_date).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: [20, 21, 22, 23]
      #   ).index(current_event) + 1,
      # career_single:
      #   current_event.event_cd == 20 ?
      #     all_hits.where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 20
      #     ).index(current_event) + 1 : nil,
      # season_single: current_event.event_cd == 20 ?
      #   all_hits.by_year(current_event.game_date.year).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 20
      #     ).index(current_event) + 1 : nil,
      # game_single: current_event.event_cd == 20 ?
      #   all_hits.by_day(current_event.game_date).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 20
      #     ).index(current_event) + 1 : nil,
      # career_double:
      #   current_event.event_cd == 21 ?
      #     all_hits.where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 21
      #     ).index(current_event) + 1 : nil,
      # season_double: current_event.event_cd == 21 ?
      #   all_hits.by_year(current_event.game_date.year).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 21
      #     ).index(current_event) + 1 : nil,
      # game_double: current_event.event_cd == 21 ?
      #   all_hits.by_day(current_event.game_date).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 21
      #     ).index(current_event) + 1 : nil,
      # career_triple:
      #   current_event.event_cd == 22 ?
      #     all_hits.where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 22
      #     ).index(current_event) + 1 : nil,
      # season_triple: current_event.event_cd == 22 ?
      #   all_hits.by_year(current_event.game_date.year).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 22
      #     ).index(current_event) + 1 : nil,
      # game_triple: current_event.event_cd == 22 ?
      #   all_hits.by_day(current_event.game_date).where(
      #     bat_id: current_event.bat_id,
      #     event_cd: 22
      #     ).index(current_event) + 1 : nil,
      career_home_run:
        current_event.event_cd == 23 ?
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
    progressbar.increment
  end
end
puts '~~~~~~~~~~~~~~~~~~~'
puts '~~ Finished hits ~~'
puts '~~~~~~~~~~~~~~~~~~~'

# If career_home_run == nil
#   generate and fill it in upon request
# Else serve the file!
