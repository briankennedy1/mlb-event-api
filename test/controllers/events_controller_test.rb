require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get '/v1/events'
    assert_response :success
    p "*" * 50
    p JSON.parse(@response.body).length
    p "*" * 50

    assert_not_nil assigns(:events)
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

end
