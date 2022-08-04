require 'rails_helper'

RSpec.describe Api::V1::WebhooksController, type: :controller do
  describe "GET /index" do
    context "with no params" do
      it "returns an ok status, admitting it's a setup request" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "with the necessary params for a create action" do
      it "returns an ok status, admitting it's a create request" do
        get :index, params: { webhook: { action: { type: 'createCard', data: { card: { id: 'foo', name: 'bar' }, list: { id: 'baz' } } } } }
        expect(response).to have_http_status(:ok)
      end

      it "increments the number of cards" do
        expect {
          get :index, params: { webhook: { action: { type: 'createCard', data: { card: { id: 'foo', name: 'bar' }, list: { id: 'baz' } } } } }
        }.to change { Card.count }.by(1)
      end
    end
  end
end
