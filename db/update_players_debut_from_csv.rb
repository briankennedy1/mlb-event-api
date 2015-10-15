require 'csv'
require 'ruby-progressbar'

csv_file = './db/players.csv'

PBAR = ProgressBar.create(
  starting_at: 0,
  total: 19_690,
  format: '%a %e %P% Processed: %c from %C'
)

CSV.foreach(csv_file, headers: true) do |row|
  player = Player.find_by(player_id: row['player_id'])
  player.update_columns(
    debut: row['debut']
  )
  PBAR.increment
end
