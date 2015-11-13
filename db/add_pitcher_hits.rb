p '%' * 50
p 'Starting add_pitcher_hits'
p '%' * 50

PLAYERS.each do |player|
  all_hits = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '20' OR
    events.pit_id = '#{player}' AND events.event_cd = '21' OR
    events.pit_id = '#{player}' AND events.event_cd = '22' OR
    events.pit_id = '#{player}' AND events.event_cd = '23' OR
  ")
  all_hits.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_hits.length,
    format: "#{PLAYERS.index(player) + 1}/#{PLAYERS.length}: #{player} %a %e %P% Processed: %c from %C"
  )

  all_hits.each do |current_event|
    season_group = all_hits.select do |hit|
      hit.game_date.year == current_event.game_date.year
    end

    game_group = all_hits.select do |hit|
      hit.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_hit: all_hits
        .index(current_event) + 1,
      pitcher_season_hit:
        season_group.index(current_event) + 1,
      pitcher_game_hit:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
