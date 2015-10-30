class Removeunusedfields < ActiveRecord::Migration
  def change
    remove_column :events, :seq_events
    remove_column :events, :year_id
  end
end
