PLAYERS.each do |player|
  all_hits = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '22' ")
  all_hits.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_hits.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_hits.each do |current_event|
    season_group = all_hits.select do |hit|
      hit.game_date.year == current_event.game_date.year
    end

    game_group = all_hits.select do |hit|
      hit.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_triple: all_hits
        .index(current_event) + 1,
      pitcher_season_triple:
        season_group.index(current_event) + 1,
      pitcher_game_triple:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
