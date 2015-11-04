p '%' * 50
p 'Starting add_pitcher_earned_runs'
p '%' * 50

PLAYERS.each do |player|
  all_earned_runs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.resp_pit_id = '#{player}' AND events.bat_dest_id = [4,6]
    OR events.run1_resp_pit_id = '#{player}' AND events.run1_dest_id = [4,6]
    OR events.run2_resp_pit_id = '#{player}' AND events.run2_dest_id = [4,6]
    OR events.run3_resp_pit_id = '#{player}' AND events.run3_dest_id = [4,6]
    ")
  all_earned_runs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_earned_runs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_earned_runs.each do |current_event|
    season_group = all_earned_runs.select do |er|
      er.game_date.year == current_event.game_date.year
    end

    game_group = all_earned_runs.select do |er|
      er.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_earned_run: all_earned_runs
        .index(current_event) + 1,
      pitcher_season_earned_run:
        season_group.index(current_event) + 1,
      pitcher_game_earned_run:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
