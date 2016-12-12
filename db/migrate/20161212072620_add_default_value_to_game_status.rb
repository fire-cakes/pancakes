class AddDefaultValueToGameStatus < ActiveRecord::Migration
  def change
    change_column_default :games, :status, 0
  end
end
