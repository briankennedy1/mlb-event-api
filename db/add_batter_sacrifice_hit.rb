p '%' * 50
p 'Starting add_batter_sacrifice_hits'
p '%' * 50

PLAYERS.each do |player|
  all_shs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.bat_id = '#{player}' AND events.sh_fl = 'T' ")
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
      batter_career_sacrifice_hit: all_shs
        .index(current_event) + 1,
      batter_season_sacrifice_hit:
        season_group.index(current_event) + 1,
      batter_game_sacrifice_hit:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
