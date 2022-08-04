class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :remote_board_card_id
      t.timestamps
    end
  end
end
