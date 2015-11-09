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

  if all_runs.empty?
    next
  else
    # Set counts of all stats to 0
    career_count = 0
    season_count = 0
    game_count = 0
    # Set a marker on the groups that will be updated as we go through events
    season_marker = all_runs.first.game_date.year
    game_marker = all_runs.first.game_id

    all_runs.each do |current_event|
      if season_marker != current_event.game_date.year
        season_marker = current_event.game_date.year
        season_count = 0
      end

      if game_marker != current_event.game_id
        game_marker = current_event.game_id
        game_count = 0
      end

      career_count += 1
      season_count += 1
      game_count += 1

      if player == current_event.bat_id
        current_event.update_columns(
          batter_career_run: career_count,
          batter_season_run: season_count,
          batter_game_run: game_count
        )
      elsif player == current_event.base1_run_id
        current_event.update_columns(
          runner1_career_run: career_count,
          runner1_season_run: season_count,
          runner1_game_run: game_count
        )
      elsif player == current_event.base2_run_id
        current_event.update_columns(
          runner2_career_run: career_count,
          runner2_season_run: season_count,
          runner2_game_run: game_count
        )
      elsif player == current_event.base3_run_id
        current_event.update_columns(
          runner3_career_run: career_count,
          runner3_season_run: season_count,
          runner3_game_run: game_count
        )
      end

      pbar.increment
    end
  end
end
