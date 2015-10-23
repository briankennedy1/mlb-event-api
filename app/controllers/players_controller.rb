class PlayersController < ApplicationController
  def index
    @players = Player.where('DATE(debut) >= ?', Date.parse('1974-01-01'))
    render json: @players, status: 200
  end

  def show
    @player = Player.find_by(player_id: params[:player_id])
    if @player.nil?
      @player = { error: 'Player not found. API documentation: http://docs.mlbevents.apiary.io/' }
      return render json: @player, status: 400
    end
    render json: @player, status: 200
  end

  def search
    query = params[:player].downcase
    @players = Player.where('lower(full_name) LIKE ? AND debut_year >= 1974', "%#{query}%").order(:debut).reverse
    render json: { players: @players }, status: 200
  end

end
