require 'ruby-progressbar'
require_relative 'players'
# sf_fl == 'T'
# event_cd == 2

PLAYERS.each do |player|
  all_sfs = Event.find_by_sql("SELECT events.* FROM events WHERE
    events.bat_id = '#{player}' AND events.sf_fl = 'T' ")
  all_sfs.sort! { |x, y| [x.game_date, x.id] <=> [y.game_date, y.id] }
  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_sfs.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_sfs.each do |current_event|
    season_group = all_sfs.select do |sf|
      sf.game_date.year == current_event.game_date.year
    end

    game_group = all_sfs.select do |sf|
      sf.game_id == current_event.game_id
    end

    current_event.update_columns(
      batter_career_sacrifice_fly: all_sfs
        .index(current_event) + 1,
      batter_season_sacrifice_fly:
        season_group.index(current_event) + 1,
      batter_game_sacrifice_fly:
        game_group.index(current_event) + 1
    )
    pbar.increment
  end
end
