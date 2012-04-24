class AddDecimalPlaceToRoutesKmColumn < ActiveRecord::Migration
  def change
  	change_column :routes, :km, :decimal, :scale => 2
  end
end
