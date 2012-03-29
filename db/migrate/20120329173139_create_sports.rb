class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.integer :id
      t.string :name
      t.string :comment
      t.datetime :lastchange

      t.timestamps
    end
  end
end
