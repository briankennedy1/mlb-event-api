require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_hpbs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.pit_id = '#{player}' AND events.event_cd = '16' ")
  all_hpbs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_hpbs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_hpbs.each do |current_event|
    season_group = all_hpbs.select do |hpb|
      hpb.game_date.year == current_event.game_date.year
    end

    game_group = all_hpbs.select do |hpb|
      hpb.game_id == current_event.game_id
    end

    current_event.update_columns(
      pitcher_career_hit_by_pitch: all_hpbs
        .index(current_event) + 1,
      pitcher_season_hit_by_pitch:
        season_group.index(current_event) + 1,
      pitcher_game_hit_by_pitch:
        game_group.index(current_event) + 1
    )

    pbar.increment
  end
end
