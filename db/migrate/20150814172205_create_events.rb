class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :GAME_ID
      t.string :PIT_ID
      t.string :BAT_ID
      t.string :EVENT_TX
      t.string :EVENT_CD

      t.timestamps null: false
    end
  end
end
