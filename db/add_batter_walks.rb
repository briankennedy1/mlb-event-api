PLAYERS.each do |player|
  all_walks = Event.where(
    bat_id: player,
    event_cd: [14, 15])
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_walks.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_walks.each do |current_event|
    season_group = all_walks.select do |walk|
      walk.game_date.year == current_event.game_date.year
    end

    game_group = all_walks.select do |walk|
      walk.game_id == current_event.game_id
    end

    current_event.update_columns(
      batter_career_walk: all_walks.index(current_event) + 1,
      batter_season_walk: season_group.index(current_event) + 1,
      batter_game_walk: game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
