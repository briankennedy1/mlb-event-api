require 'csv'

csv_text = File.read('./events/2014.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Event.create!(row.to_hash)
end
