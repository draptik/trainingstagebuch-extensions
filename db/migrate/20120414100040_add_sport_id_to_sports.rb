class AddSportIdToSports < ActiveRecord::Migration
  def change
  	add_column :sports, :sport_id, :integer
    add_index :sports, :sport_id
  end
end
