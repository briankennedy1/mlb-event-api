PLAYERS.each do |player|
  all_hits = Event.where(
    bat_id: player,
    event_cd: [20, 21, 22, 23])
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_hits.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_hits.each do |current_event|
    current_event.update_columns(
      career_hit: all_hits
        .index(current_event) + 1,
      season_hit: all_hits
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      game_hit: all_hits
        .where(game_id: current_event.game_id)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
