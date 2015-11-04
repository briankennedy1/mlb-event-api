class PlayersController < ApplicationController
  def index
    @players = Player.select(
      'id, player_id, full_name, debut, debut_year'
    ).where(
      'debut_year >= ?', 1974
    )

    render json: @players, status: 200
  end

  def show
    @player = Player.select(
      'id, player_id, full_name, debut, debut_year, first_name, last_name'
    ).find_by(
      player_id: params[:player_id]
    )

    if @player.nil?
      @player = {
        error: 'Player not found.',
        message: "Please supply a player ID like 'troum001'.
        API documentation: http://docs.mlbevents.apiary.io/"
      }
      return render json: @player, status: 400
    end

    render json: @player, status: 200
  end

  def search
    query = params[:player].downcase

    @players = Player.select(
      'id, player_id, full_name, debut'
    ).where(
      'lower(full_name) LIKE ? AND debut_year >= 1974', "%#{query}%"
    ).order(:debut).reverse

    render json: { players: @players }, status: 200
  end

  def bad_request
    if params[:request_type] == 'batting' ||
       params[:request_type] == 'pitching'

      render json: {
        error: 'Bad request',
        message: 'Please supply an event type. API documentation: http://docs.mlbevents.apiary.io/'
      }, status: 400

    else
      render json: {
        error: 'Bad request',
        message: "Please supply 'batting' or 'pitching' to request events.
        API documentation: http://docs.mlbevents.apiary.io/"
      }, status: 400
    end
  end
end
