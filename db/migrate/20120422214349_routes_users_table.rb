class RoutesUsersTable < ActiveRecord::Migration
  def up
  	create_table :routes_users, :id => false do |t|
      t.integer :user_id
      t.integer :route_id      
    end
  end

  def down
  	drop_table :routes_users
  end
end
