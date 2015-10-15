class AddPlayerDebutYearField < ActiveRecord::Migration
  def change
    add_column :players, :debut_year, :integer
  end
end
