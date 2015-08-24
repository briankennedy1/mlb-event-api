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
    events << Event.new(row.to_hash)
    progressbar.increment
  end
  Event.import events

  puts "Finished #{csv_file}"
  puts "*" * 50
end
#
# csv_text = File.read('./events/2014.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Event.create!(row.to_hash)
# end
