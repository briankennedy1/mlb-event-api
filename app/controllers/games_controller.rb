class GamesController < ApplicationController
  # Return an error message if a game isn't specified.
  # There are too many games to return all events from all games.
  def all_games
    render json: {
      message: 'Please use a specific game_id to look up games.
      For example: /v1/games/ANA201404020'
    }, status: 400
  end

  # Return all events from a specific game
  def show_game
    @game = event_search(game_id: params[:game_id])
    render json: @game, status: 200
  end
end
