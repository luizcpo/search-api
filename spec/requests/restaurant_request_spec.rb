require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  describe 'GET /index' do
    context 'with no params' do
      before do
        query_double = double('RestaurantSearchService', search: [])
        allow(RestaurantSearchService).to receive(:new).and_return(query_double)
      end

      it 'returns http success' do
        get '/restaurants'
        expect(response).to have_http_status(:success)
      end
    end

    context 'wit valid params' do
      it 'returns http success' do
        get '/restaurants', params: { :name => "Chow" }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      it 'returns http success' do
        get '/restaurants', params: { :name => "^%Chow" }
        expect(response).to have_http_status(200)
      end
    end
  end
end
