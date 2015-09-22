class AddIndexForGameId < ActiveRecord::Migration
  def change
    add_index :events, :game_id
  end
end
