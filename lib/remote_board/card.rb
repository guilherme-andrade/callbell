require 'dry/struct'

module RemoteBoard
  class Card < Dry::Struct
    attribute :name, Types::String
    attribute :list_id, Types::String
    attribute :id, Types::String
  end
end
