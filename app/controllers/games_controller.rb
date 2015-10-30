class GamesController < ApplicationController
  # Return an error message if a game isn't specified.
  # There are too many games to return all events from all games.
  def all_games
    render json: {
      error: 'Request not specific enough',
      message: 'Please use a specific game_id to look up games.
      API documentation: http://docs.mlbevents.apiary.io/'
    }, status: 400
  end

  # Return all events from a specific game
  def show_game
    @game = Event.where(
      game_id: params[:game_id]
    ).order(:game_date, :id)

    render json: @game, status: 200
  end
end
