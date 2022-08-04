module Cards
  module Webhooks
    class Process
      include UseCase
      include CallbellFullstackAssignment::Deps[:remote_board]

      step :process_webhook
      step :perform_operation

      private

      def process_webhook(params)
        remote_board.process_webhook(params)
      end

      def perform_operation(webhook_result, params)
        case webhook_result.operation
        when :create
          create_card(webhook_result.card)
        when :update
          update_card(webhook_result.card)
        when :delete
          delete_card(webhook_result.card)
        when :setup
          Success(webhook_result)
        end
      end

      private

      def create_card(remote_card)
        card = Card.new(name: remote_card.name, remote_board_card_id: remote_card.id)
        if card.save
          Success(card)
        else
          Failure(card.errors)
        end
      end

      def update_card(remote_card)
        card = Card.find_by(remote_board_card_id: remote_card.id)
        return Failure([:not_found, "Card not found"]) if card.nil?

        if card.update(name: remote_card.name)
          Success(card)
        else
          Failure(card.errors)
        end
      end

      def delete_card(remote_card)
        card = Card.find_by(remote_board_card_id: remote_card.id)
        return Failure([:not_found, "Card not found"]) if card.nil?

        if card.destroy
          Success(card)
        else
          Failure(card.errors)
        end
      end
    end
  end
end

