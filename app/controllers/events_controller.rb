class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    # GET to /events will show this message. Too many events to render them all.
    # Maybe include some kind of pagination?
    @events = Event.first(250)
    render json: @events
  end

  def show
    # GET to /events/1 will show one specific event
    render json: @event
  end

  def all_games
    # GET to /game will show this message. Too many games to render them all.
    render json: {message: 'Please use a specific GAME_ID to look up games. For example: /v1/games/ANA201404020'}
  end

  def show_game
    # Specific game
    @game = event_search(GAME_ID: params[:game_id])
    render json: @game
  end

  def show_batter_events
    if params[:bat_id] == nil
      render json: {error: 'Missing bat_id', message: 'Please query the data with a specific batter using bat_id. For example, a query for Mike Trout would include bat_id=troum001'}

    else
      if params[:event_type]
        # Build hash of events and corresponding codes to streamline search
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

        # Access hash of events and corresponding codes to streamline search
        if event_types.has_key?(params[:event_type])
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: event_types[params[:event_type]]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          @batter_events = event_search(search_options)

        elsif params[:event_type] == 'at_bats'
          # Look for events with at bat flag (AB_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            AB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          @batter_events = event_search(search_options)

        elsif params[:event_type] == 'plate_appearances'
          # Look for events with at bat flag (AB_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            AB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          at_bats = event_search(search_options)

          # Add walks (14 are regular, 15 are intentional)
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: [14,15]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          walks = event_search(search_options)

          # Add hit by pitch events
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: 16
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          hit_by_pitches = event_search(search_options)

          # Add events with sacrifice hit flag (SH_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            SH_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          sacrifice_hits = event_search(search_options)

          # Add events with sacrifice fly flag (SF_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            SF_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          sacrifice_flies = event_search(search_options)

          # Plate appearances = At bats + walks + hit by pitches + sacrifice hits + sacrifice flies
          @batter_events = at_bats + walks + hit_by_pitches + sacrifice_hits + sacrifice_flies
          @batter_events.sort_by! { |events| events[:id] }

        elsif params[:event_type] == 'rbi'
          @batter_events = event_search(BAT_ID: params[:bat_id], RBI_CT: [1,2,3,4])

          # Math to test if RBI is working
          # @rbi_count = 0
          # @batter_events.each {|event| @rbi_count += event[:RBI_CT]}
          # p '*' * 50
          # p @rbi_count
          # p '*' * 50

        elsif params[:event_type] == 'stolen_bases'
          search_options = {
            BASE1_RUN_ID: params[:bat_id],
            RUN1_SB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          steal_second = event_search(search_options)

          search_options = {
            BASE2_RUN_ID: params[:bat_id],
            RUN2_SB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          steal_third = event_search(search_options)

          search_options = {
            BASE3_RUN_ID: params[:bat_id],
            RUN3_SB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          steal_home = event_search(search_options)

          @batter_events = steal_second + steal_third + steal_home
          @batter_events.sort_by! { |events| events[:id] }

        elsif params[:event_type] == 'caught_stealing'
          search_options = {
            BASE1_RUN_ID: params[:bat_id],
            RUN1_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          caught_at_second = event_search(search_options)

          search_options = {
            BASE2_RUN_ID: params[:bat_id],
            RUN2_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          caught_at_third = event_search(search_options)

          search_options = {
            BASE3_RUN_ID: params[:bat_id],
            RUN3_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          caught_at_home = event_search(search_options)

          @batter_events = caught_at_second + caught_at_third + caught_at_home
          @batter_events.sort_by! { |events| events[:id] }

        elsif params[:event_type] == 'runs'
          search_options = {
            BAT_ID: params[:bat_id],
            BAT_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          scored_batting = event_search(search_options)

          search_options = {
            BASE1_RUN_ID: params[:bat_id],
            RUN1_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          scored_from_first = event_search(search_options)

          search_options = {
            BASE2_RUN_ID: params[:bat_id],
            RUN2_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          scored_from_second = event_search(search_options)

          search_options = {
            BASE3_RUN_ID: params[:bat_id],
            RUN3_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          scored_from_third = event_search(search_options)

          @batter_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @batter_events.sort_by! { |events| events[:id] }

        else
          @batter_events = {error: 'Query not found', message: 'Please check the documentation for the specific keys you can use in your GET request to search for specific events.'}
        end

      else
        @batter_events = event_search(BAT_ID: params[:bat_id])
      end
      render json: @batter_events
    end
  end

  def show_pitcher_events
    if params[:pit_id] == nil
      render json: {error: 'Missing pit_id', message: 'Please query the data with a specific pitcher using pit_id. For example, a query for Zack Greinke would include pit_id=greiz001'}

    else
      if params[:event_type]
        # Build hash of events and corresponding codes to streamline search
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
          'pick_offs' => 8,
          'balks' => 11,
        }

        # Access hash of events and corresponding codes to streamline search
        if event_types.has_key?(params[:event_type])
          search_options = {
            PIT_ID: params[:pit_id],
            EVENT_CD: event_types[params[:event_type]]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          @pitcher_events = event_search(search_options)

        elsif params[:event_type] == 'wild_pitches'
          search_options = {
            PIT_ID: params[:pit_id], WP_FL: 'T'
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          @pitcher_events = event_search(search_options)

        elsif params[:event_type] == 'earned_runs'
          # This method may be problematic because it returns multiple copies of an event if more than one run was scored in that event. For example, a two-run home run would return one event for the batter scoring and the same event for the runner on first scoring.
          # Although this is just one event, I want it to be represented multiple times, one for each person it 'belongs' to. So I actually like this approach for now.
          search_options = {
            PIT_ID: params[:pit_id],
            BAT_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_batting = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN1_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_first = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN2_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_second = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN3_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_third = event_search(search_options)

          @pitcher_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @pitcher_events.sort_by! { |events| events[:id] }

        elsif params[:event_type] == 'runs_allowed'
          search_options = {
            PIT_ID: params[:pit_id],
            BAT_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_batting = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN1_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_first = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN2_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_second = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN3_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          scored_from_third = event_search(search_options)

          @pitcher_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @pitcher_events.sort_by! { |events| events[:id] }

        elsif params[:event_type] == 'batters_faced'


          @pitcher_events =
            # Look for events with at bat flag (AB_FL) set to true
            event_search(PIT_ID: params[:pit_id], AB_FL: 'T') +
            # Add walks (14 are regular, 15 are intentional)
            event_search(PIT_ID: params[:pit_id], EVENT_CD: [14,15]) +
            # Add hit by pitch events
            event_search(PIT_ID: params[:pit_id], EVENT_CD: 16) +
            # Add events with sacrifice hit flag (SH_FL) set to true
            event_search(PIT_ID: params[:pit_id], SH_FL: 'T') +
            # Add events with sacrifice fly flag (SF_FL) set to true
            event_search(PIT_ID: params[:pit_id], SF_FL: 'T')
          # Sort 'em
          @pitcher_events.sort_by! { |events| events[:id] }

        else
          @pitcher_events = {error: 'Query not found', message: 'Please check the documentation for the specific keys you can use in your GET request to search for specific events.'}
        end

      else
        @pitcher_events = event_search(PIT_ID: params[:pit_id])
      end
      render json: @pitcher_events
    end
  end



  private

    def event_search(options)
      Event.where(options).order(:id)
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:GAME_ID, :PIT_ID, :BAT_ID, :EVENT_TX, :EVENT_CD)
    end
end
