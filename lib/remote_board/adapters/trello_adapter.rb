require 'trello'
require 'dry/monads/result'
require 'dry/validation'

module RemoteBoard
  module Adapters
    class TrelloAdapter
      include Dry::Monads::Result::Mixin

      attr_reader :board

      WebhookResult = OpenStruct

      def self.finalize!
        Trello.configure do |config|
          config.developer_public_key = RemoteBoard.config.trello.key
          config.member_token = RemoteBoard.config.trello.token
        end
      end

      def initialize
        @board = Trello::Board.find(ENV['TRELLO_BOARD_ID'])
      end

      private

      def list_id
        board.lists.first.id        
      end

      module PublicInstanceMethods
        def process_webhook(params)
          return Success(WebhookResult.new(operation: :setup)) unless params['webhook']
          
          validation_result = WebhookContract.new.call(params)
          return Failure(validation_result.errors) if validation_result.failure?

          card = card_from_webhook(params)
          case params.dig('webhook', 'action', 'type')
          when 'createCard'
            Success(WebhookResult.new(card: card, operation: :create))
          when 'updateCard'
            Success(WebhookResult.new(card: card, operation: :update))
          when 'deleteCard'
            Success(WebhookResult.new(card: card, operation: :delete))
          end
        end

        def create_card(params)
          trello_card = Trello::Card.create(name: params[:name], list_id: list_id)
          card = build_remote_board_card(trello_card)
          Success(card)
        rescue Trello::Error => e
          Failure(e)        
        end

        private

        def build_remote_board_card(trello_card)
          Card.new(name: trello_card.name, list_id: trello_card.list_id, id: trello_card.id)
        end

        def card_from_webhook(params)
          data = params.dig('webhook', 'action', 'data')
          
          Card.new(
            name: data.dig('card', 'name'),
            id: data.dig('card', 'id'),
            list_id: data.dig('list', 'id')
          )
        end
      end

      include PublicInstanceMethods
    end

    class WebhookContract < Dry::Validation::Contract
      params do
        required(:webhook).hash do
          required(:action).hash do
            required(:type).filled(:string)
            required(:data).hash do
              required(:card).hash do
                required(:name).filled(:string)
                required(:id).filled(:string)
              end
              required(:list).hash do
                required(:id).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
