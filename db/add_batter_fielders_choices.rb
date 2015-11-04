p '%' * 50
p 'Starting add_batter_fielders_choices'
p '%' * 50

PLAYERS.each do |player|
  all_fcs = Event.where(
    bat_id: player,
    event_cd: 19)
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_fcs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_fcs.each do |current_event|
    current_event.update_columns(
      batter_career_fielders_choice: all_fcs
        .index(current_event) + 1,
      batter_season_fielders_choice: all_fcs
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      batter_game_fielders_choice: all_fcs
        .where(game_id: current_event.game_id)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
