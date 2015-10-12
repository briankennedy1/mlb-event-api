require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_picks = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '8' ")
  all_picks.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_picks.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_picks.each do |current_event|
    season_group = all_picks.select do |pick|
      pick.game_date.year == current_event.game_date.year
    end

    game_group = all_picks.select do |pick|
      pick.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_pick_off: all_picks
        .index(current_event) + 1,
      pitcher_season_pick_off:
        season_group.index(current_event) + 1,
      pitcher_game_pick_off:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
