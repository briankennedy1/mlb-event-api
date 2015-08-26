require 'csv'
require 'ruby-progressbar'
require 'activerecord-import'

files = Dir.glob('./events/*.csv')

files.each do |csv_file|
  puts "*" * 50
  puts "Starting #{csv_file}"
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, :headers => true)
  progressbar = ProgressBar.create(:starting_at => 0, :total => csv.count)

  # events = []
  csv.each do |row|
    current_event = Event.new(row.to_hash)

    date_to_add = "#{current_event.GAME_ID[3..6]}-#{current_event.GAME_ID[7..8]}-#{current_event.GAME_ID[9..10]}"
    current_event.attributes= {game_date: date_to_add}

    # Count hits by batter up to this point
    # Need to be more specific in key names.
    if current_event.EVENT_CD == 20 ||
       current_event.EVENT_CD == 21 ||
       current_event.EVENT_CD == 22 ||
       current_event.EVENT_CD == 23

    current_event.attributes= {
      career_hit: Event.where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1,
      season_hit: Event.by_year(current_event.game_date.year).where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1,
      game_hit: Event.by_day(current_event.game_date).where(BAT_ID: current_event.BAT_ID, EVENT_CD: [20,21,22,23]).count + 1
    }
    end
    current_event.save
    # events << current_event
    progressbar.increment
  end
  # Event.import events

  puts "Finished #{csv_file}"
  puts "*" * 50
end
