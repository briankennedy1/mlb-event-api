require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { BAT_ID: @event.BAT_ID, EVENT_CD: @event.EVENT_CD, EVENT_TX: @event.EVENT_TX, GAME_ID: @event.GAME_ID, PIT_ID: @event.PIT_ID }
    end

    assert_response 201
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { BAT_ID: @event.BAT_ID, EVENT_CD: @event.EVENT_CD, EVENT_TX: @event.EVENT_TX, GAME_ID: @event.GAME_ID, PIT_ID: @event.PIT_ID }
    assert_response 204
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_response 204
  end
end
