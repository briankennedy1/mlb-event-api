class PlayersController < ApplicationController
  def index
    @players = Player.where('DATE(debut) >= ?', Date.parse('1974-01-01'))
    render json: @players, status: 200
  end
  def search
    query = params[:player].downcase
    @players = Player.where('lower(first_name) LIKE ? or lower(last_name) LIKE ?', "%#{query}%", "%#{query}%")
    render json: { players: @players }, status: 200
  end
end
