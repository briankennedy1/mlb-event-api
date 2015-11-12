p '%' * 50
p 'Starting add_batter_sacrifices'
p '%' * 50

PLAYERS.each do |player|
  all_sacrifices = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.bat_id = '#{player}' AND events.sf_fl = 'T' OR events.bat_id = '#{player}' AND events.sh_fl = 'T' ")
  all_sacrifices.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_sacrifices.length,
    format: "#{PLAYERS.index(player) + 1}/#{PLAYERS.length}: #{player} %a %e %P% Processed: %c from %C"
  )

  all_sacrifices.each do |current_event|
    season_group = all_sacrifices.select do |sf|
      sf.game_date.year == current_event.game_date.year
    end

    game_group = all_sacrifices.select do |sf|
      sf.game_id == current_event.game_id
    end

    current_event.update_columns(
      batter_career_sacrifice: all_sacrifices
        .index(current_event) + 1,
      batter_season_sacrifice:
        season_group.index(current_event) + 1,
      batter_game_sacrifice:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
