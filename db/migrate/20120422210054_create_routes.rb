class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :route_id
      t.string :name
      t.decimal :km
      t.string :gpsies
      t.text :comment
      t.datetime :lastchanged

      t.timestamps
    end

    add_index :routes, :route_id
    add_index :routes, :gpsies
  end
end
