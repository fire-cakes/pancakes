class RemovePlayerIdFromPiece < ActiveRecord::Migration
  def change
    remove_column :pieces, :player_id
  end
end
