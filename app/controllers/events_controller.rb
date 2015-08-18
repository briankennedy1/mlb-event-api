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
    if params[:event_type]
      event_types = {
        "hits" => [20,21,22,23],
        "outs" => 2,
        "strikeouts" => 3,
        "walks" => [14, 15],
        "intentional_walks" => 15,
        "hit_by_pitches" => 16,
        "errors" => 18,
        "fielders_choices" => 19,
        "singles" => 20,
        "doubles" => 21,
        "triples" => 22,
        "home_runs" => 23,
      }
      if event_types.has_key?(params[:event_type])
        @batter_events = Event.where(BAT_ID: params[:bat_id], EVENT_CD: event_types[params[:event_type]])
      else
        @batter_events = {message: "Please use one of these keys in your GET URL to search for specific events: #{event_types.keys}"}
      end
      else
        @batter_events = Event.where(BAT_ID: params[:bat_id])
      end
    render json: @batter_events
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
