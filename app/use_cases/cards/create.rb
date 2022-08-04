module Cards
  class Create
    include UseCase[:validated]
    include CallbellFullstackAssignment::Deps[:remote_board]

    params do
      required(:name).filled(:string)
    end

    step :create_card

    private

    def create_card(params)
      remote_board.create_card(params)
    end
  end
end

