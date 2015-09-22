require 'ruby-progressbar'
require_relative 'players'

PLAYERS.each do |player|
  all_strikeouts = Event.where(
    pit_id: player,
    event_cd: 3)
    .order(:game_date, :id)

  pbar = ProgressBar.create(
    starting_at: 0,
    total: all_strikeouts.length,
    format: "Current player: #{player} %a %e %P% Processed: %c from %C"
  )

  all_strikeouts.each do |current_event|
    current_event.update_columns(
      pitcher_career_strikeout: all_strikeouts
        .index(current_event) + 1,
      pitcher_season_strikeout: all_strikeouts
        .by_year(current_event.game_date.year)
        .index(current_event) + 1,
      # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      # !! New code for doubleheaders
      # !! Need to go back through batter events
      # !! and fix
      # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      pitcher_game_strikeout: all_strikeouts
        .where(game_id: current_event.game_id)
        .index(current_event) + 1
    )
    pbar.increment
  end
end
