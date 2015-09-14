# Order all events by game date
# Find every event with a hit
# Add game/season/career hits
puts '~~~~~~~~~~~~~~~~~'
puts '~~ Adding hits ~~'
puts '~~~~~~~~~~~~~~~~~'
# throw in bondb001 to test it on the first run
all_hits = Event.where(bat_id: bondb001, event_cd: [20,21,22,23]).order(:game_date, :id)
progressbar = ProgressBar.create(starting_at:0, total: all_hits.count, format: "%a %e %P% Processed: %c from %C")

all_hits.each do |current_event|
  current_event.attributes= {
    career_hit:
      all_hits.where(
      bat_id: current_event.bat_id,
      event_cd: [20,21,22,23])
      .index(current_event) + 1,
    season_hit:
      all_hits.by_year(current_event.game_date.year).where(
      bat_id: current_event.bat_id,
      event_cd: [20,21,22,23])
      .index(current_event) + 1,
    game_hit:
      all_hits.by_day(current_event.game_date).where(
      bat_id: current_event.bat_id,
      event_cd: [20,21,22,23])
      .index(current_event) + 1,
    career_single:
      current_event.event_cd == 20 ?
        all_hits.where(
        bat_id: current_event.bat_id,
        event_cd: 20)
        .index(current_event) + 1 : nil,
    season_single: current_event.event_cd == 20 ?
      all_hits.by_year(current_event.game_date.year).where(
        bat_id: current_event.bat_id,
        event_cd: 20)
        .index(current_event) + 1 : nil,
    game_single: current_event.event_cd == 20 ?
      all_hits.by_day(current_event.game_date).where(
        bat_id: current_event.bat_id,
        event_cd: 20)
        .index(current_event) + 1 : nil,
    career_double:
      current_event.event_cd == 21 ?
        all_hits.where(
        bat_id: current_event.bat_id,
        event_cd: 21)
        .index(current_event) + 1 : nil,
    season_double: current_event.event_cd == 21 ?
      all_hits.by_year(current_event.game_date.year).where(
        bat_id: current_event.bat_id,
        event_cd: 21)
        .index(current_event) + 1 : nil,
    game_double: current_event.event_cd == 21 ?
      all_hits.by_day(current_event.game_date).where(
        bat_id: current_event.bat_id,
        event_cd: 21)
        .index(current_event) + 1 : nil,
    career_triple:
      current_event.event_cd == 22 ?
        all_hits.where(
        bat_id: current_event.bat_id,
        event_cd: 22)
        .index(current_event) + 1 : nil,
    season_triple: current_event.event_cd == 22 ?
      all_hits.by_year(current_event.game_date.year).where(
        bat_id: current_event.bat_id,
        event_cd: 22)
        .index(current_event) + 1 : nil,
    game_triple: current_event.event_cd == 22 ?
      all_hits.by_day(current_event.game_date).where(
        bat_id: current_event.bat_id,
        event_cd: 22)
        .index(current_event) + 1 : nil,
    career_home_run:
      current_event.event_cd == 23 ?
        all_hits.where(
        bat_id: current_event.bat_id,
        event_cd: 23)
        .index(current_event) + 1 : nil,
    season_home_run: current_event.event_cd == 23 ?
      all_hits.by_year(current_event.game_date.year).where(
        bat_id: current_event.bat_id,
        event_cd: 23)
        .index(current_event) + 1 : nil,
    game_home_run: current_event.event_cd == 23 ?
      all_hits.by_day(current_event.game_date).where(
        bat_id: current_event.bat_id,
        event_cd: 23)
        .index(current_event) + 1 : nil
  }
  current_event.save
  progressbar.increment
end
puts '~~~~~~~~~~~~~~~~~~~'
puts '~~ Finished hits ~~'
puts '~~~~~~~~~~~~~~~~~~~'

# If career_home_run == nil
#   generate and fill it in upon request
# Else serve the file!
