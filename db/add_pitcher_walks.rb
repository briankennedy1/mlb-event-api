p '%' * 50
p 'Starting add_pitcher_walks'
p '%' * 50

PLAYERS.each do |player|
  all_bbs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '14' Or
    events.pit_id = '#{player}' AND events.event_cd = '15'
   ")
  all_bbs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_bbs.length,
    format: "#{PLAYERS.index(player) + 1}/#{PLAYERS.length}: #{player} %a %e %P% Processed: %c from %C"
  )

  all_bbs.each do |current_event|
    season_group = all_bbs.select do |bb|
      bb.game_date.year == current_event.game_date.year
    end

    game_group = all_bbs.select do |bb|
      bb.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_walk: all_bbs
        .index(current_event) + 1,
      pitcher_season_walk:
        season_group.index(current_event) + 1,
      pitcher_game_walk:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
