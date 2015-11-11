p '%' * 50
p 'Starting add_pitcher_earned_runs'
p '%' * 50

PLAYERS.each do |player|
  all_earned_runs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.resp_pit_id = '#{player}' AND events.bat_dest_id = 4 OR events.resp_pit_id = '#{player}' AND events.bat_dest_id = 6 OR events.run1_resp_pit_id = '#{player}' AND events.run1_dest_id = 4 OR events.run1_resp_pit_id = '#{player}' AND events.run1_dest_id = 6 OR events.run2_resp_pit_id = '#{player}' AND events.run2_dest_id = 4 OR events.run2_resp_pit_id = '#{player}' AND events.run2_dest_id = 6 OR events.run3_resp_pit_id = '#{player}' AND events.run3_dest_id = 4 OR events.run3_resp_pit_id = '#{player}' AND events.run3_dest_id = 6
    ")
  all_earned_runs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_earned_runs.length,
    format: "#{PLAYERS.index(player) + 1}/#{PLAYERS.length}: #{player} %a %e %P% Processed: %c from %C"
  )

  if all_earned_runs.empty?
    next
  else
    # Set counts of all stats to 0
    career_count = 0
    season_count = 0
    game_count = 0
    # Set a marker on the groups that will be updated as we go through events
    season_marker = all_earned_runs.first.game_date.year
    game_marker = all_earned_runs.first.game_id

    all_earned_runs.each do |current_event|
      if season_marker != current_event.game_date.year
        season_marker = current_event.game_date.year
        season_count = 0
      end

      if game_marker != current_event.game_id
        game_marker = current_event.game_id
        game_count = 0
      end

      career_count += current_event.event_runs_ct
      season_count += current_event.event_runs_ct
      game_count += current_event.event_runs_ct

      current_event.update_columns(
        pitcher_career_earned_run: career_count,
        pitcher_season_earned_run: season_count,
        pitcher_game_earned_run: game_count
      )
      pbar.increment
    end
  end
  # all_earned_runs.each do |current_event|
  #   season_group = all_earned_runs.select do |er|
  #     er.game_date.year == current_event.game_date.year
  #   end
  #
  #   game_group = all_earned_runs.select do |er|
  #     er.game_id == current_event.game_id
  #   end
  #
  #   current_event.update_columns(
  #     pitcher_career_earned_run: all_earned_runs
  #       .index(current_event) + 1,
  #     pitcher_season_earned_run:
  #       season_group.index(current_event) + 1,
  #     pitcher_game_earned_run:
  #       game_group.index(current_event) + 1
  #   )
  #
  #   pbar.increment
  # end
end
