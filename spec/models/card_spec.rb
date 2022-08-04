require 'rails_helper'

RSpec.describe Card, type: :model do
  # TODO: Test your card model logic here (if present).
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:remote_board_card_id).of_type(:string) }
end
