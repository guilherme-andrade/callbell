class Api::V1::WebhooksController < ApplicationController
  def index
    resolve('cards.webhooks.process').call(params) do |on|
      on.success do |result|
        head :ok
      end

      on.failure :not_found do |(code, message)|
        render json: { error: message }, status: :not_found
      end      

      on.failure do |(code, message)|
        render json: { error: message }, status: :unprocessable_entity
      end
    end
  end
end
