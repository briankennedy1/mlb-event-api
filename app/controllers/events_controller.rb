class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # Return the first 250 events if no event is specified.
  # There are too many events to return them all.
  # Maybe include some kind of pagination in the future?
  def index
    @events = Event.first(250)
    render json: @events
  end

  # Return the specified event
  def show
    render json: @event
  end

  # Return an error message if a game isn't specified.
  # There are too many games to return all events from all games.
  def all_games
    render json: {message: 'Please use a specific game_id to look up games. For example: /v1/games/ANA201404020'}
  end

  # Return all events from a specific game
  def show_game
    @game = event_search(GAME_ID: params[:game_id])
    render json: @game
  end

  # Return events based on a specific batter.
  def show_batter_events
    # Return error message if no batter is specified.
    if params[:bat_id] == nil
      render json: {error: 'Missing bat_id', message: 'Please query the data with a specific batter using bat_id. For example, a query for Mike Trout would include bat_id=troum001'}

    else
      # Build hash of events and corresponding codes to streamline search
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

        # Return events by searching hash for corresponding event code.
        if event_types.has_key?(params[:event_type])
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: event_types[params[:event_type]]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          @batter_events = event_search(search_options)

        # Look for events with at bat flag (AB_FL) set to true
        elsif params[:event_type] == 'at_bats'
          search_options = {
            BAT_ID: params[:bat_id],
            AB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          @batter_events = event_search(search_options)

        # Return events with plate appearances by specified batter.
        # Plate apperances = at bats + walks + hit by pitches + sacrifice hits + sacrifice flies
        elsif params[:event_type] == 'plate_appearances'
          # Look for events with at bat flag (AB_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            AB_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          at_bats = event_search(search_options)

          # Add walks (14 are regular, 15 are intentional)
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: [14,15]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          walks = event_search(search_options)

          # Add hit by pitch events
          search_options = {
            BAT_ID: params[:bat_id],
            EVENT_CD: 16
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          hit_by_pitches = event_search(search_options)

          # Add events with sacrifice hit flag (SH_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            SH_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          sacrifice_hits = event_search(search_options)

          # Add events with sacrifice fly flag (SF_FL) set to true
          search_options = {
            BAT_ID: params[:bat_id],
            SF_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          sacrifice_flies = event_search(search_options)

          @batter_events = at_bats + walks + hit_by_pitches + sacrifice_hits + sacrifice_flies
          @batter_events.sort_by! { |events| events[:id] }

        # Return events with a RBI by specified batter
        elsif params[:event_type] == 'rbi'
          search_options = {
            BAT_ID: params[:bat_id],
            RBI_CT: [1,2,3,4]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          @batter_events = event_search(search_options)

          # Number of events returned does not equal actual RBI because you can get between 1 and 4 RBI in one event.
          # Math to add up if RBI totals:
          # @rbi_count = 0
          # @batter_events.each {|event| @rbi_count += event[:RBI_CT]}
          # p '*' * 50
          # p @rbi_count
          # p '*' * 50

        # Return events with stolen bases (second, third and home) by a specified baserunner (using bat_id).
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
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          steal_home = event_search(search_options)

          @batter_events = steal_second + steal_third + steal_home
          @batter_events.sort_by! { |events| events[:id] }

        # Return events where the baserunner (using bat_id) was caught stealing ( at second, third and home).
        elsif params[:event_type] == 'caught_stealing'
          search_options = {
            BASE1_RUN_ID: params[:bat_id],
            RUN1_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          caught_at_second = event_search(search_options)

          search_options = {
            BASE2_RUN_ID: params[:bat_id],
            RUN2_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          caught_at_third = event_search(search_options)

          search_options = {
            BASE3_RUN_ID: params[:bat_id],
            RUN3_CS_FL: 'T'
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          caught_at_home = event_search(search_options)

          @batter_events = caught_at_second + caught_at_third + caught_at_home
          @batter_events.sort_by! { |events| events[:id] }

        # Return events where the batter or baserunner (using bat_id) scored on the play.
        elsif params[:event_type] == 'runs'
          search_options = {
            BAT_ID: params[:bat_id],
            BAT_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_batting = event_search(search_options)

          search_options = {
            BASE1_RUN_ID: params[:bat_id],
            RUN1_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_first = event_search(search_options)

          search_options = {
            BASE2_RUN_ID: params[:bat_id],
            RUN2_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_second = event_search(search_options)

          search_options = {
            BASE3_RUN_ID: params[:bat_id],
            RUN3_DEST_ID: [4,5,6]
          }
          search_options[:PIT_ID] = params[:pit_id] if params[:pit_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_third = event_search(search_options)

          @batter_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @batter_events.sort_by! { |events| events[:id] }

        # Return an error message if the event was not properly specified.
        else
          @batter_events = {error: 'Query not found', message: 'Please check the documentation for the specific keys you can use in your GET request to search for specific events.'}
        end

      # Return all the events by a  specific batter if no event is specified.
      else
        @batter_events = event_search(BAT_ID: params[:bat_id])
      end
      render json: @batter_events
    end
  end

  # Return events based on a specific pitcher.
  def show_pitcher_events
    # Return error message if no pitcher is specified.
    if params[:pit_id] == nil
      render json: {error: 'Missing pit_id', message: 'Please query the data with a specific pitcher using pit_id. For example, a query for Zack Greinke would include pit_id=greiz001'}

    else
      # Build hash of events and corresponding codes to streamline search
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
          'pick_offs' => 8,
          'balks' => 11,
        }

        # Return pitcher events by searching hash for corresponding event code.
        if event_types.has_key?(params[:event_type])
          search_options = {
            PIT_ID: params[:pit_id],
            EVENT_CD: event_types[params[:event_type]]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          @pitcher_events = event_search(search_options)

        # Return events where the pitcher threw wild pitches
        elsif params[:event_type] == 'wild_pitches'
          search_options = {
            PIT_ID: params[:pit_id], WP_FL: 'T'
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          @pitcher_events = event_search(search_options)

        # Return events where the pitcher allowed earned runs
        elsif params[:event_type] == 'earned_runs'
          # This method may be problematic because it returns multiple copies of an event if more than one run was scored in that event. For example, a two-run home run would return one event for the batter scoring and the same event for the runner on first scoring.
          # Although this is just one event, I want it to be represented multiple times, one for each person it 'belongs' to. So I actually like this approach for now.
          search_options = {
            PIT_ID: params[:pit_id],
            BAT_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_batting = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN1_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_first = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN2_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_second = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN3_DEST_ID: 4
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_third = event_search(search_options)

          @pitcher_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @pitcher_events.sort_by! { |events| events[:id] }

        # Return events where the pitcher allowed runs
        elsif params[:event_type] == 'runs_allowed'
          search_options = {
            PIT_ID: params[:pit_id],
            BAT_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_batting = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN1_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_first = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN2_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_second = event_search(search_options)

          search_options = {
            PIT_ID: params[:pit_id],
            RUN3_DEST_ID: [4,5,6]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          scored_from_third = event_search(search_options)

          @pitcher_events = scored_batting + scored_from_first + scored_from_second + scored_from_third
          @pitcher_events.sort_by! { |events| events[:id] }

        # Return events where pitcher faced batters.
        # Batters faced = at bats + walks + hit by pitches + sacrifice hits + sacrifice flies.
        elsif params[:event_type] == 'batters_faced'
          # Look for events with at bat flag (AB_FL) set to true
          search_options = {
            PIT_ID: params[:pit_id],
            AB_FL: 'T'
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          at_bats = event_search(search_options)

          # Add walks (14 are regular, 15 are intentional)
          search_options = {
            PIT_ID: params[:pit_id],
            EVENT_CD: [14,15]
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          walks = event_search(search_options)

          # Add hit by pitch events
          search_options = {
            PIT_ID: params[:pit_id],
            EVENT_CD: 16
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          hit_by_pitches = event_search(search_options)

          # Add events with sacrifice hit flag (SH_FL) set to true
          search_options = {
            PIT_ID: params[:pit_id],
            SH_FL: 'T'
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          sacrifice_hits = event_search(search_options)

          # Add events with sacrifice fly flag (SF_FL) set to true
          search_options = {
            PIT_ID: params[:pit_id],
            SF_FL: 'T'
          }
          search_options[:BAT_ID] = params[:bat_id] if params[:bat_id]
          search_options[:GAME_END_FL] = 'T' if params[:game_ending] == 'true'
          sacrifice_flies = event_search(search_options)

          @pitcher_events = at_bats + walks + hit_by_pitches + sacrifice_hits + sacrifice_flies
          @pitcher_events.sort_by! { |events| events[:id] }

        # Return an error message if the event was not properly specified.
        else
          @pitcher_events = {error: 'Query not found', message: 'Please check the documentation for the specific keys you can use in your GET request to search for specific events.'}
        end

      # Return all events from specified pitcher.
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
