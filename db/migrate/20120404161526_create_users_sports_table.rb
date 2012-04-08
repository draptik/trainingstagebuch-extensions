class CreateUsersSportsTable < ActiveRecord::Migration
  def up
    create_table :users_sports, :id => false do |t|
      t.integer :user_id
      t.integer :sport_id      
    end
  end

  def down
    drop_table :users_sports
  end
end
