require 'dry/configurable'

require 'remote_board/types'
require 'remote_board/card'
require 'remote_board/adapters/trello_adapter'

module RemoteBoard
  extend Dry::Configurable

  setting :adapter, default: :trello

  setting :trello do
    setting :key, default: ENV['TRELLO_KEY']
    setting :token, default: ENV['TRELLO_TOKEN']
    setting :board_id, default: ENV['TRELLO_BOARD_ID']
    setting :webhook_url, default: ENV['TRELLO_WEBHOOK_URL']
  end

  ADAPTERS = {
    trello: Adapters::TrelloAdapter
  }.freeze

  def self.configure(&blk)
    super
    adapter_klass.finalize!
  end

  def self.adapter_klass
    ADAPTERS[config.adapter]
  end

  def self.adapter
    @adapter ||= adapter_klass.new
  end
end
