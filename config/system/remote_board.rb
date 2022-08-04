CallbellFullstackAssignment::Container.boot(:remote_board) do 
  init do
    require 'remote_board'

    RemoteBoard.configure do |config|
      config.trello.key = ENV['TRELLO_KEY']
      config.trello.token = ENV['TRELLO_TOKEN']
      config.trello.board_id = ENV['TRELLO_BOARD_ID']
      config.trello.webhook_url = ENV['TRELLO_WEBHOOK_URL']

      config.adapter = :trello
    end
  end

  start do
    register(:remote_board) do 
      RemoteBoard.adapter
    end
  end
end
