require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_bbs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '15' ")
  all_bbs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_bbs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_bbs.each do |current_event|
    season_group = all_bbs.select do |bb|
      bb.game_date.year == current_event.game_date.year
    end

    game_group = all_bbs.select do |bb|
      bb.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_intentional_walk: all_bbs
        .index(current_event) + 1,
      pitcher_season_intentional_walk:
        season_group.index(current_event) + 1,
      pitcher_game_intentional_walk:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
