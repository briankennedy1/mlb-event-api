class PlayersController < ApplicationController
  def index
    @players = Player.where('DATE(debut) >= ?', Date.parse('1974-01-01'))
    render json: @players, status: 200
  end
end
