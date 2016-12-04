class RenamePieceMoveToPieceTurn < ActiveRecord::Migration
  def change
    rename_column :pieces, :piece_move, :piece_turn
  end
end
