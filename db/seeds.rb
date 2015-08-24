require 'csv'
require 'ruby-progressbar'

files = Dir.glob('./events/*.csv')

files.each do |csv_file|
  p "*" * 50
  p "Starting #{csv_file}"
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, :headers => true)
  progressbar = ProgressBar.create(:starting_at => 0, :total => csv.count)
  csv.each do |row|
    Event.create!(row.to_hash)
    progressbar.increment
  end
  p "Finished #{csv_file}"
  p "*" * 50
end
#
# csv_text = File.read('./events/2014.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Event.create!(row.to_hash)
# end
