class AddIndexToUsersUserIdAndMaterialId < ActiveRecord::Migration
  def change
  	remove_index :materials, [:user_id, :material_id]
  	add_index :materials, [:user_id, :material_id], unique: true
  end
end
