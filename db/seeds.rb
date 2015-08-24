require 'csv'

files = Dir.glob('./events/*.csv')

files.each do |csv_file|
  csv_text = File.read(csv_file)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Event.create!(row.to_hash)
  end
  p "*" * 50
  p "Finished #{csv_file}"
  p "*" * 50
end
#
# csv_text = File.read('./events/2014.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Event.create!(row.to_hash)
# end
