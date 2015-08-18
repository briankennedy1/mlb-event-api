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
        'hits' => [20,21,22,23],
        'outs' => 2,
        'strikeouts' => 3,
        'walks' => [14, 15],
        'intentional_walks' => 15,
        'hit_by_pitches' => 16,
        'errors' => 18,
        'fielders_choices' => 19,
        'singles' => 20,
        'doubles' => 21,
        'triples' => 22,
        'home_runs' => 23,
      }

      if event_types.has_key?(params[:event_type])
        @batter_events = Event.where(BAT_ID: params[:bat_id], EVENT_CD: event_types[params[:event_type]]).order(:id)

      elsif params[:event_type] == 'at_bats'
        # Look for events with at bat flag (AB_FL) set to true
        @batter_events = Event.where(BAT_ID: params[:bat_id], AB_FL: 'T').order(:id)

      elsif params[:event_type] == 'plate_appearances'
          # Plate appearances = At bats + walks + hit by pitches + sacrifice hits + sacrifice flies
        @batter_events =
          # Look for events with at bat flag (AB_FL) set to true
          Event.where(BAT_ID: params[:bat_id], AB_FL: 'T') +
          # Add walks (14 are regular, 15 are intentional)
          Event.where(BAT_ID: params[:bat_id], EVENT_CD: [14,15]) +
          # Add hit by pitch events
          Event.where(BAT_ID: params[:bat_id], EVENT_CD: 16) +
          # Add events with sacrifice hit flag (SH_FL) set to true
          Event.where(BAT_ID: params[:bat_id], SH_FL: 'T') +
          # Add events with sacrifice fly flag (SF_FL) set to true
          Event.where(BAT_ID: params[:bat_id], SF_FL: 'T')
        @batter_events.sort_by! { |events| events[:id] }

      elsif params[:event_type] == 'games'
        # This should pull from a table of games instead of events.
        # Right now it just returns a count of games batter appeared in.
        @batter_events = Event.where(BAT_ID: params[:bat_id])
        @batter_events = @batter_events.select(:GAME_ID).distinct.count

      elsif params[:event_type] == 'rbi'
        @batter_events = Event.where(BAT_ID: params[:bat_id], RBI_CT: [1,2,3,4]).order(:id)

        # Math to test if RBI is working
        # @rbi_count = 0
        # @batter_events.each {|event| @rbi_count += event[:RBI_CT]}
        # p '*' * 50
        # p @rbi_count
        # p '*' * 50

      else
        @batter_events = {error: 'Query not found', message: 'Please check the documentation for the specific keys you can use in your GET request to search for specific events.'}
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
