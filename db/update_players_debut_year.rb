require 'csv'
require 'ruby-progressbar'

PBAR = ProgressBar.create(
  starting_at: 0,
  total: 19_690,
  format: '%a %e %P% Processed: %c from %C'
)

all_players = Player.all

all_players.each do |player|
  player.update_columns(
    debut_year: player.debut.year
  )
  PBAR.increment
end
