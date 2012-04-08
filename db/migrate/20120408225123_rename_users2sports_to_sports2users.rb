class RenameUsers2sportsToSports2users < ActiveRecord::Migration
  def up
    rename_table :users_sports, :sports_users
  end

  def down
    rename_table :sports_users, :users_sports
  end
end
