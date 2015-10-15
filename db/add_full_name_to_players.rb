all_players = Player.all

all_players.each do |player|
  player.update_columns(full_name: "#{player.first_name} #{player.last_name}")
end
