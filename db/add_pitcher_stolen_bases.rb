PLAYERS.each do |player|
  all_sbs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '4' ")
  all_sbs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_sbs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_sbs.each do |current_event|
    season_group = all_sbs.select do |sb|
      sb.game_date.year == current_event.game_date.year
    end

    game_group = all_sbs.select do |sb|
      sb.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_stolen_base: all_sbs
        .index(current_event) + 1,
      pitcher_season_stolen_base:
        season_group.index(current_event) + 1,
      pitcher_game_stolen_base:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
