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

  events = []
  csv.each do |row|
    current_event = Event.new(row.to_hash)
    date_to_add = "#{current_event.GAME_ID[3..6]}-#{current_event.GAME_ID[7..8]}-#{current_event.GAME_ID[9..10]}"
    current_event.attributes= {game_date: date_to_add}
    events << current_event
    progressbar.increment
  end
  Event.import events

  puts "Finished #{csv_file}"
  puts "*" * 50
end
