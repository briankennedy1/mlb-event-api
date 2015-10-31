PLAYERS.each do |player|
  all_hbp = Event.where(
    bat_id: player,
    event_cd: 16)
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_hits.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_hbp.each do |current_event|
    current_event.update_columns(
      batter_career_hit_by_pitch: all_hbp
        .index(current_event) + 1,
      batter_season_hit_by_pitch: all_hbp
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      batter_game_hit_by_pitch: all_hbp
        .where(game_id: current_event.game_id)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
