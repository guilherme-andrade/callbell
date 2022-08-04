require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do
  describe "GET /index" do
    it "returns a list of cards" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns an empty list of card' do
      get :index
      expect(JSON.parse(response.body)).to eq([])
    end

    context 'with cards in the db' do
      before do
        Card.create(name: 'Foo', remote_board_card_id: '1')
      end

      it 'returns a list of cards' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of cards' do
        get :index
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end
  end

  describe "POST /create" do
    context 'with valid params' do
      it "creates a new card" do
        post :create, params: { name: "New card" }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it "returns an error" do
        post :create, params: { name: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
