p '%' * 50
p 'Starting add_pitcher_outs'
p '%' * 50

PLAYERS.each do |player|
  all_outs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = 2 OR events.pit_id = '#{player}' AND events.event_cd = 3 ")
  all_outs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_outs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  if all_outs.empty?
    next
  else
    career_count = 0
    season_count = 0
    game_count = 0
    # Set a marker on the groups that will be updated as we go through events
    season_marker = all_outs.first.game_date.year
    game_marker = all_outs.first.game_id

    all_outs.each do |current_event|
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

      current_event.update_columns(
        pitcher_career_out: career_count,
        pitcher_season_out: season_count,
        pitcher_game_out: game_count
      )

      # Old code
      # season_group = all_outs.select do |out|
      #   out.game_date.year == current_event.game_date.year
      # end
      #
      # game_group = all_outs.select do |out|
      #   out.game_id == current_event.game_id
      # end
      #
      # current_event.update_columns(
      #   pitcher_career_out: all_outs
      #     .index(current_event) + 1,
      #   pitcher_season_out:
      #     season_group.index(current_event) + 1,
      #   pitcher_game_out:
      #     game_group.index(current_event) + 1
      # )
      pbar.increment
    end
  end
end
