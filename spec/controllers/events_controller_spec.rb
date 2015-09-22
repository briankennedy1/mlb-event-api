require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET /v1/events' do
    context 'when try to get' do
      it 'should render 250 events' do
        Event.create(game_id: 1)
        get '/v1/events/1'
        expect(last_response.status).to eq 200
      end
    end
  end
end
