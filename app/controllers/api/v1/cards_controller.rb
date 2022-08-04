class Api::V1::CardsController < ApplicationController
  # TODO: Fill the controller actions for the API
  def index
    @cards = Card.all
    render json: @cards, status: :ok
  end

  def create
    resolve('cards.create').call(params) do |on|
      on.success do |card|
        render json: card, status: :created
      end

      on.failure do |(code, message)|
        render json: { error: message }, status: :unprocessable_entity
      end
    end
  end
end
