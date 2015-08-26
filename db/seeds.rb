require 'csv'
require 'ruby-progressbar'

files = Dir.glob('./events/*.csv')

files.each do |csv_file|
  puts "*" * 50
  puts "Starting #{csv_file}"
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, :headers => true)
  progressbar = ProgressBar.create(:starting_at => 0, :total => csv.count)

  csv.each do |row|
    current_event = Event.new(row.to_hash)

    date_to_add = "#{current_event.GAME_ID[3..6]}-#{current_event.GAME_ID[7..8]}-#{current_event.GAME_ID[9..10]}"
    current_event.attributes= {game_date: date_to_add}

    current_event.save
    progressbar.increment
  end

  puts "Finished #{csv_file}"
  puts "*" * 50
end

# Order all events by game date
# Find every event with a hit
# Add game/season/career hits
puts "~~~~~~~~~~~~~~~~~"
puts "~~ Adding hits ~~"
puts "~~~~~~~~~~~~~~~~~"
all_hits = Event.where(EVENT_CD: [20,21,22,23]).order(:game_date)
progressbar = ProgressBar.create(:starting_at => 0, :total => all_hits.count)

all_hits.each do |current_event|
    current_event.attributes= {
      career_hit: Event.where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1,
      season_hit: Event.by_year(current_event.game_date.year).where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1,
      game_hit: Event.by_day(current_event.game_date).where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1
    }
  end
  current_event.save
  progressbar.increment
end
