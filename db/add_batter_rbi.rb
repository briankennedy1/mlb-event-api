p '%' * 50
p 'Starting add_batter_rbi'
p '%' * 50

PLAYERS.each do |player|
  all_rbi = Event.where(
    bat_id: player,
    rbi_ct: [1, 2, 3, 4])
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_rbi.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  current_season = all_rbi.first.game_date.year
  current_game = all_rbi.first.game_id
  running_career_rbi = 0
  running_season_rbi = 0
  running_game_rbi = 0

  all_rbi.each do |current_event|
    running_career_rbi += current_event.rbi_ct

    if current_season == current_event.game_date.year
      running_season_rbi += current_event.rbi_ct
    else
      current_season = current_event.game_date.year
      running_season_rbi = 0
      running_season_rbi += current_event.rbi_ct
    end

    if current_game == current_event.game_id
      running_game_rbi += current_event.rbi_ct
    else
      current_game = current_event.game_id
      running_game_rbi = 0
      running_game_rbi += current_event.rbi_ct
    end

    current_event.update_columns(
      batter_career_rbi: running_career_rbi,
      batter_season_rbi: running_season_rbi,
      batter_game_rbi: running_game_rbi
    )
    pbar.increment
  end
end
