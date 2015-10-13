PLAYERS.each do |player|
  all_wps = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '9' ")
  all_wps.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_wps.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_wps.each do |current_event|
    season_group = all_wps.select do |wp|
      wp.game_date.year == current_event.game_date.year
    end

    game_group = all_wps.select do |wp|
      wp.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_wild_pitch: all_wps
        .index(current_event) + 1,
      pitcher_season_wild_pitch:
        season_group.index(current_event) + 1,
      pitcher_game_wild_pitch:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
