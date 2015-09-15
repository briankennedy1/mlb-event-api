class AddIndexForGameDate < ActiveRecord::Migration
  def change
    add_index :events, :game_date
  end
end
