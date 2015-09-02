require 'csv'
require 'ruby-progressbar'
# require 'activerecord-import'

files = Dir.glob('./events/*.csv')

files.each do |csv_file|
  puts '*' * 50
  puts "Starting #{csv_file}"
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, :headers => true)
  progressbar = ProgressBar.create(
    starting_at: 0,
    total: csv.count,
    format: '%a %e %P% Processed: %c from %C'
  )

  csv.each do |row|
    current_event = Event.new(row.to_hash)

    date_to_add =
      "#{current_event.game_id[3..6]}-
      #{current_event.game_id[7..8]}-
      #{current_event.game_id[9..10]}"
    current_event.attributes= { game_date: date_to_add }

    current_event.save
    progressbar.increment
  end
  puts "Finished #{csv_file}"
end

# Order all events by game date
# Find every event with a hit
# Add game/season/career hits
# puts "~~~~~~~~~~~~~~~~~"
# puts "~~ Adding hits ~~"
# puts "~~~~~~~~~~~~~~~~~"
# all_hits = Event.where(EVENT_CD: [20,21,22,23]).order(:game_date, :id)
# progressbar = ProgressBar.create(starting_at:0, total: all_hits.count, format: "%a %e %P% Processed: %c from %C")
#
# all_hits.each do |current_event|
#   current_event.attributes= {
#     career_hit:
#       all_hits.where(
#       BAT_ID: current_event.BAT_ID,
#       EVENT_CD: [20,21,22,23])
#       .index(current_event) + 1,
#     season_hit:
#       all_hits.by_year(current_event.game_date.year).where(
#       BAT_ID: current_event.BAT_ID,
#       EVENT_CD: [20,21,22,23])
#       .index(current_event) + 1,
#     game_hit:
#       all_hits.by_day(current_event.game_date).where(
#       BAT_ID: current_event.BAT_ID,
#       EVENT_CD: [20,21,22,23])
#       .index(current_event) + 1,
#     career_single:
#       current_event.EVENT_CD == 20 ?
#         all_hits.where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 20)
#         .index(current_event) + 1 : nil,
#     season_single: current_event.EVENT_CD == 20 ?
#       all_hits.by_year(current_event.game_date.year).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 20)
#         .index(current_event) + 1 : nil,
#     game_single: current_event.EVENT_CD == 20 ?
#       all_hits.by_day(current_event.game_date).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 20)
#         .index(current_event) + 1 : nil,
#     career_double:
#       current_event.EVENT_CD == 21 ?
#         all_hits.where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 21)
#         .index(current_event) + 1 : nil,
#     season_double: current_event.EVENT_CD == 21 ?
#       all_hits.by_year(current_event.game_date.year).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 21)
#         .index(current_event) + 1 : nil,
#     game_double: current_event.EVENT_CD == 21 ?
#       all_hits.by_day(current_event.game_date).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 21)
#         .index(current_event) + 1 : nil,
#     career_triple:
#       current_event.EVENT_CD == 22 ?
#         all_hits.where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 22)
#         .index(current_event) + 1 : nil,
#     season_triple: current_event.EVENT_CD == 22 ?
#       all_hits.by_year(current_event.game_date.year).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 22)
#         .index(current_event) + 1 : nil,
#     game_triple: current_event.EVENT_CD == 22 ?
#       all_hits.by_day(current_event.game_date).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 22)
#         .index(current_event) + 1 : nil,
#     career_home_run:
#       current_event.EVENT_CD == 23 ?
#         all_hits.where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 23)
#         .index(current_event) + 1 : nil,
#     season_home_run: current_event.EVENT_CD == 23 ?
#       all_hits.by_year(current_event.game_date.year).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 23)
#         .index(current_event) + 1 : nil,
#     game_home_run: current_event.EVENT_CD == 23 ?
#       all_hits.by_day(current_event.game_date).where(
#         BAT_ID: current_event.BAT_ID,
#         EVENT_CD: 23)
#         .index(current_event) + 1 : nil
#   }
#   current_event.save
#   progressbar.increment
# end
# puts "~~~~~~~~~~~~~~~~~~~"
# puts "~~ Finished hits ~~"
# puts "~~~~~~~~~~~~~~~~~~~"


# If career_home_run == nil
  # generate and fill it in upon request
# Else serve the file!
