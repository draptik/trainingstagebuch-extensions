class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :material_id
      t.integer :user_id
      t.string :name
      t.string :status
      t.string :comment
      t.integer :count
      t.decimal :duration
      t.decimal :distance_km
      t.datetime :lastchange

      t.timestamps
    end
    add_index :materials, [:user_id, :material_id]
  end
end
