p '%' * 50
p 'Starting add_batter_runs'
p '%' * 50

PLAYERS.each do |player|
  all_runs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.bat_id = '#{player}' AND events.bat_dest_id = 4 OR events.bat_id = '#{player}' AND events.bat_dest_id = 5 OR events.bat_id = '#{player}' AND events.bat_dest_id = 6 OR events.base1_run_id = '#{player}' AND events.run1_dest_id = 4 OR events.base1_run_id = '#{player}' AND events.run1_dest_id = 5 OR events.base1_run_id = '#{player}' AND events.run1_dest_id = 6 OR events.base2_run_id = '#{player}' AND events.run2_dest_id = 4 OR events.base2_run_id = '#{player}' AND events.run2_dest_id = 5 OR events.base2_run_id = '#{player}' AND events.run2_dest_id = 6 OR events.base3_run_id = '#{player}' AND events.run3_dest_id = 4 OR events.base3_run_id = '#{player}' AND events.run3_dest_id = 5 OR events.base3_run_id = '#{player}' AND events.run3_dest_id = 6 ")

  all_runs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_runs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_runs.each do |current_event|
    season_group = all_runs.select do |sb|
      sb.game_date.year == current_event.game_date.year
    end

    game_group = all_runs.select do |sb|
      sb.game_id == current_event.game_id
    end

    current_event.update_columns(
      batter_career_run: all_runs
        .index(current_event) + 1,
      batter_season_run:
        season_group.index(current_event) + 1,
      batter_game_run:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
