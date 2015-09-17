require 'csv'
require 'ruby-progressbar'
require 'smarter_csv'
require 'parallel'

files = Dir.glob('./events/*.csv')

PBAR = ProgressBar.create(
  starting_at: 0,
  total: files.count,
  format: '%a %e %P% Processed: %c from %C'
)

files.each do |csv_file|
  def worker(array_of_hashes)
    ActiveRecord::Base.connection.reconnect!
    array_of_hashes.each do |data_hash|
      current_event = Event.new(data_hash)
      date_to_add = "#{current_event.game_id[3..6]}-#{current_event.game_id[7..8]}-#{current_event.game_id[9..10]}"

      # Consider changing .attributes= to .update
      # and remove .save
      current_event.attributes= { game_date: date_to_add }
      current_event.save
    end
  end

  chunks = SmarterCSV.process(csv_file, chunk_size: 1_000)

  Parallel.each(chunks) do |chunk|
    worker(chunk)
  end
  PBAR.increment
end
