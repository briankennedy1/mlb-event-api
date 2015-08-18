class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.first(100)
    render json: @events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render json: @event
  end

  def all_games
    render json: {message: 'Please GET to a specific GAME_ID to look up games. For example: /v1/games/ANA201404020'}
  end

  def show_game
    @game = Event.where(GAME_ID: params[:game_id])
    render json: @game
  end

  def show_batter_events
    @batter_events = Event.where(BAT_ID: params[:bat_id])
    render json: @batter_events
  end

  def show_batter_hits
    if params[:hit_type]
      hit_types = {"singles" => 1, "doubles" => 2, "triples" => 3, "homeruns" => 4}
      if hit_types.has_key?(params[:hit_type])
        @batter_hits = Event.where(BAT_ID: params[:bat_id], H_CD: hit_types[params[:hit_type]])
      else
        @batter_hits = {message: 'Please use \'singles\', \'doubles\', \'triples\' or \'homeruns\' in your URL'}
      end
    else
      @batter_hits = Event.where(BAT_ID: params[:bat_id], H_CD: [1,2,3,4])
    end
    render json: @batter_hits
  end


  # POST /events
  # POST /events.json
  # def create
  #   @event = Event.new(event_params)
  #
  #   if @event.save
  #     render json: @event, status: :created, location: @event
  #   else
  #     render json: @event.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  # def update
  #   @event = Event.find(params[:id])
  #
  #   if @event.update(event_params)
  #     head :no_content
  #   else
  #     render json: @event.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /events/1
  # DELETE /events/1.json
  # def destroy
  #   @event.destroy
  #
  #   head :no_content
  # end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:GAME_ID, :PIT_ID, :BAT_ID, :EVENT_TX, :EVENT_CD)
    end
end
