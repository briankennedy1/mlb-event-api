class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # Return the first 250 events if no event is specified.
  # There are too many events to return them all.
  # Maybe include some kind of pagination in the future?
  def index
    @events = Event.first(250)
    render json: @events, status: 200
  end

  # Return the specified event
  def show
    render json: @event, status: 200
  end

  # Return events based on a specific batter.
  def show_batter_events
    # Build hash of events and corresponding codes to streamline search
    if params[:event_type]
      event_types = {
        'hits' => [20, 21, 22, 23],
        'outs' => [2, 3],
        'strikeouts' => 3,
        'walks' => [14, 15],
        'intentional_walks' => 15,
        'hit_by_pitches' => 16,
        'errors' => 18,
        'fielders_choices' => 19,
        'singles' => 20,
        'doubles' => 21,
        'triples' => 22,
        'home_runs' => 23
      }

      # Return events by searching hash for corresponding event code.
      if event_types.key?(params[:event_type])
        search_options = {
          bat_id: params[:bat_id],
          event_cd: event_types[params[:event_type]]
        }
        batting_options(search_options)
        @batter_events = event_search(search_options)

      # Look for events with at bat flag (ab_fl) set to true
      elsif params[:event_type] == 'at_bats'
        search_options = {
          bat_id: params[:bat_id],
          ab_fl: 'T'
        }

        batting_options(search_options)
        @batter_events = event_search(search_options)

      elsif params[:event_type] == 'sacrifices'
        # Add events with sacrifice fly flag (sf_fl) or sacrifice hit flag
        # (sh_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          sf_fl: 'T'
        }
        batting_options(search_options)
        sacrifice_hits = event_search(search_options)

        search_options = {
          bat_id: params[:bat_id],
          sh_fl: 'T'
        }
        batting_options(search_options)
        sacrifice_flies = event_search(search_options)

        @batter_events = sacrifice_hits + sacrifice_flies
        @batter_events.sort_by! { |events| [events[:game_date], events[:id]] }

      elsif params[:event_type] == 'sacrifice_hits'
        # Add events with sacrifice hit flag (sh_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          sh_fl: 'T'
        }
        batting_options(search_options)
        @batter_events = event_search(search_options)

      elsif params[:event_type] == 'sacrifice_flies'
        # Add events with sacrifice fly flag (sf_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          sf_fl: 'T'
        }
        batting_options(search_options)
        @batter_events = event_search(search_options)

      # Return events with plate appearances by specified batter.
      # Plate apperances = at bats + walks + hit by pitches +
      # sacrifice hits + sacrifice flies
      elsif params[:event_type] == 'plate_appearances'
        # Look for events with at bat flag (ab_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          ab_fl: 'T'
        }
        batting_options(search_options)
        at_bats = event_search(search_options)

        # Add walks (14 are regular, 15 are intentional)
        search_options = {
          bat_id: params[:bat_id],
          event_cd: [14, 15]
        }
        batting_options(search_options)
        walks = event_search(search_options)

        # Add hit by pitch events
        search_options = {
          bat_id: params[:bat_id],
          event_cd: 16
        }
        batting_options(search_options)
        hit_by_pitches = event_search(search_options)

        # Add events with sacrifice hit flag (sh_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          sh_fl: 'T'
        }
        batting_options(search_options)
        sacrifice_hits = event_search(search_options)

        # Add events with sacrifice fly flag (sf_fl) set to true
        search_options = {
          bat_id: params[:bat_id],
          sf_fl: 'T'
        }
        batting_options(search_options)
        sacrifice_flies = event_search(search_options)

        @batter_events =
          at_bats +
          walks +
          hit_by_pitches +
          sacrifice_hits +
          sacrifice_flies
        @batter_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return events with a RBI by specified batter
      elsif params[:event_type] == 'rbi'
        search_options = {
          bat_id: params[:bat_id],
          rbi_ct: [1, 2, 3, 4]
        }
        batting_options(search_options)
        @batter_events = event_search(search_options)

      # Number of events returned does not equal actual RBI
      # because you can get between 1 and 4 RBI in one event.
      # Math to add up if RBI totals:
      # @rbi_count = 0
      # @batter_events.each {|event| @rbi_count += event[:rbi_ct]}
      # p '*' * 50
      # p @rbi_count
      # p '*' * 50

      # Return events with stolen bases (second, third and home)
      # by a specified baserunner (using bat_id).
      elsif params[:event_type] == 'stolen_bases'
        search_options = {
          base1_run_id: params[:bat_id],
          run1_sb_fl: 'T'
        }
        batting_options(search_options)
        steal_second = event_search(search_options)

        search_options = {
          base2_run_id: params[:bat_id],
          run2_sb_fl: 'T'
        }
        batting_options(search_options)
        steal_third = event_search(search_options)

        search_options = {
          base3_run_id: params[:bat_id],
          run3_sb_fl: 'T'
        }
        batting_options(search_options)
        steal_home = event_search(search_options)

        @batter_events = steal_second + steal_third + steal_home
        @batter_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return events where the baserunner (using bat_id)
      # was caught stealing ( at second, third and home).
      elsif params[:event_type] == 'caught_stealing'
        search_options = {
          base1_run_id: params[:bat_id],
          run1_cs_fl: 'T'
        }
        batting_options(search_options)
        caught_at_second = event_search(search_options)

        search_options = {
          base2_run_id: params[:bat_id],
          run2_cs_fl: 'T'
        }
        batting_options(search_options)
        caught_at_third = event_search(search_options)

        search_options = {
          base3_run_id: params[:bat_id],
          run3_cs_fl: 'T'
        }
        batting_options(search_options)
        caught_at_home = event_search(search_options)

        @batter_events = caught_at_second + caught_at_third + caught_at_home
        @batter_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return events where the batter or baserunner
      # (using bat_id) scored on the play.
      elsif params[:event_type] == 'runs'
        search_options = {
          bat_id: params[:bat_id],
          # Destination code 4, 5 and 6 all mean the runner scores.
          # 4 = runner scored
          # 5 = runner scored, unearned
          # 6 = runner scored, unearned to team, earned to pitcher
          # Ref: http://chadwick.sourceforge.net/doc/cwevent.html#cwtools-cwevent-plays
          bat_dest_id: [4, 5, 6]
        }
        batting_options(search_options)
        scored_batting = event_search(search_options)

        search_options = {
          base1_run_id: params[:bat_id],
          run1_dest_id: [4, 5, 6]
        }
        batting_options(search_options)
        scored_from_first = event_search(search_options)

        search_options = {
          base2_run_id: params[:bat_id],
          run2_dest_id: [4, 5, 6]
        }
        batting_options(search_options)
        scored_from_second = event_search(search_options)

        search_options = {
          base3_run_id: params[:bat_id],
          run3_dest_id: [4, 5, 6]
        }
        batting_options(search_options)
        scored_from_third = event_search(search_options)

        @batter_events =
          scored_batting +
          scored_from_first +
          scored_from_second +
          scored_from_third
        @batter_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return an error message if the event was not properly specified.
      else
        return event_not_found
      end

    # Return all the events by a  specific batter if no event is specified.
    else
      @batter_events = event_search(bat_id: params[:bat_id])
    end
    render json: {
      player: params[:bat_id],
      event_type: params[:event_type],
      batting_or_pitching: 'batting',
      data: @batter_events
    }, status: 200
  end

  # Return events based on a specific pitcher.
  def show_pitcher_events
    # Build hash of events and corresponding codes to streamline search
    if params[:event_type]
      event_types = {
        'hits' => [20, 21, 22, 23],
        'outs' => [2, 3],
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
        'balks' => 11
      }

      # Return pitcher events by searching hash for corresponding event code.
      if event_types.key?(params[:event_type])
        search_options = {
          resp_pit_id: params[:pit_id],
          event_cd: event_types[params[:event_type]]
        }

        pitching_options(search_options)
        @pitcher_events = event_search(search_options)

      # Return events where the pitcher threw wild pitches
      elsif params[:event_type] == 'wild_pitches'
        search_options = {
          pit_id: params[:pit_id],
          wp_fl: 'T'
        }
        pitching_options(search_options)
        @pitcher_events = event_search(search_options)

      # Return events where the pitcher allowed earned runs
      elsif params[:event_type] == 'earned_runs'
        # This method returns multiple copies of an event if more than one
        # run was scored in that event.
        # For example: a two-run home run would return one event for the
        # batter scoring and the same event for the runner scoring.
        # Although this is just one event, I want it to be represented
        # multiple times, one for each person it 'belongs' to.
        search_options = {
          resp_pit_id: params[:pit_id],
          bat_dest_id: [4, 6]
        }
        pitching_options(search_options)
        scored_batting = event_search(search_options)

        search_options = {
          run1_resp_pit_id: params[:pit_id],
          run1_dest_id: [4, 6]
        }
        pitching_options(search_options)
        scored_from_first = event_search(search_options)

        search_options = {
          run2_resp_pit_id: params[:pit_id],
          run2_dest_id: [4, 6]
        }
        pitching_options(search_options)
        scored_from_second = event_search(search_options)

        search_options = {
          run3_resp_pit_id: params[:pit_id],
          run3_dest_id: [4, 6]
        }
        pitching_options(search_options)
        scored_from_third = event_search(search_options)

        @pitcher_events =
          scored_batting +
          scored_from_first +
          scored_from_second +
          scored_from_third
        @pitcher_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return events where the pitcher allowed runs
      elsif params[:event_type] == 'runs_allowed'
        search_options = {
          resp_pit_id: params[:pit_id],
          bat_dest_id: [4, 5, 6]
        }
        pitching_options(search_options)
        scored_batting = event_search(search_options)

        search_options = {
          run1_resp_pit_id: params[:pit_id],
          run1_dest_id: [4, 5, 6]
        }
        pitching_options(search_options)
        scored_from_first = event_search(search_options)

        search_options = {
          run2_resp_pit_id: params[:pit_id],
          run2_dest_id: [4, 5, 6]
        }
        pitching_options(search_options)
        scored_from_second = event_search(search_options)

        search_options = {
          run3_resp_pit_id: params[:pit_id],
          run3_dest_id: [4, 5, 6]
        }
        pitching_options(search_options)
        scored_from_third = event_search(search_options)

        @pitcher_events =
          scored_batting +
          scored_from_first +
          scored_from_second +
          scored_from_third
        @pitcher_events.sort_by! { |events| [events[:game_date], events[:id]] }

      # Return events where pitcher faced batters.
      # Batters faced = at bats + walks + hit by pitches +
      # sacrifice hits + sacrifice flies.
      elsif params[:event_type] == 'batters_faced'
        # Look for events with at bat flag (ab_fl) set to true
        search_options = {
          pit_id: params[:pit_id],
          ab_fl: 'T'
        }
        pitching_options(search_options)
        at_bats = event_search(search_options)

        # Add walks (14 are regular, 15 are intentional)
        search_options = {
          pit_id: params[:pit_id],
          event_cd: [14, 15]
        }
        pitching_options(search_options)
        walks = event_search(search_options)

        # Add hit by pitch events
        search_options = {
          pit_id: params[:pit_id],
          event_cd: 16
        }
        pitching_options(search_options)
        hit_by_pitches = event_search(search_options)

        # Add events with sacrifice hit flag (sh_fl) set to true
        search_options = {
          pit_id: params[:pit_id],
          sh_fl: 'T'
        }
        pitching_options(search_options)
        sacrifice_hits = event_search(search_options)

        # Add events with sacrifice fly flag (sf_fl) set to true
        search_options = {
          pit_id: params[:pit_id],
          sf_fl: 'T'
        }
        pitching_options(search_options)
        sacrifice_flies = event_search(search_options)

        @pitcher_events =
          at_bats +
          walks + hit_by_pitches +
          sacrifice_hits +
          sacrifice_flies
        @pitcher_events.sort_by! do |events|
          [events[:game_date], events[:id]]
        end

      # Return an error message if the event was not properly specified.
      else
        return event_not_found
      end

    # Return all events from specified pitcher.
    else
      @pitcher_events = event_search(pit_id: params[:pit_id])
    end
    # render json: @pitcher_events, status: 200
    render json: {
      player: params[:pit_id],
      event_type: params[:event_type],
      batting_or_pitching: 'pitching',
      data: @pitcher_events
    }, status: 200
  end

  private

  def event_search(options)
    if options.key?(:year)
      Event.by_year(options[:year])
        .where(options.except(:year))
        .order(:game_date, :id)
    else
      Event.where(options)
        .order(:game_date, :id)
    end
  end

  def pitching_options(search_options)
    search_options[:year] = params[:year] if params[:year]
    search_options[:bat_id] = params[:bat_id] if params[:bat_id]
    search_options[:bat_team_id] = params[:opponent] if params[:opponent]
    search_options[:game_end_fl] = 'T' if params[:game_ending] == 'true'
    search_options[:leadoff_fl] = 'T' if params[:lead_off] == 'true'
    search_options[:inn_ct] = 1 if params[:lead_off] == 'true'
    search_options
  end

  def batting_options(search_options)
    search_options[:year] = params[:year] if params[:year]
    search_options[:pit_id] = params[:pit_id] if params[:pit_id]
    search_options[:fld_team_id] = params[:opponent] if params[:opponent]
    search_options[:game_end_fl] = 'T' if params[:game_ending] == 'true'
    search_options[:leadoff_fl] = 'T' if params[:lead_off] == 'true'
    search_options[:inn_ct] = 1 if params[:lead_off] == 'true'
    search_options
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event)
      .permit(:game_id, :pit_id, :bat_id, :event_tx, :event_cd)
  end

  def event_not_found
    render json: {
      error: 'Event not found',
      message: 'Check the API documentation for events you can query: http://docs.mlbevents.apiary.io/'
    }, status: 400
  end
end
