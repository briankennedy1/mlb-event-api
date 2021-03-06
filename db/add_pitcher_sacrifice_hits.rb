PLAYERS.each do |player|
  all_shs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.sh_fl = 'T' ")
  all_shs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_shs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_shs.each do |current_event|
    season_group = all_shs.select do |sh|
      sh.game_date.year == current_event.game_date.year
    end

    game_group = all_shs.select do |sh|
      sh.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_sacrifice_hit: all_shs
        .index(current_event) + 1,
      pitcher_season_sacrifice_hit:
        season_group.index(current_event) + 1,
      pitcher_game_sacrifice_hit:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
