class AddPieceTurnColumnAndRemoveFirstMoveColumn < ActiveRecord::Migration
  def change
    add_column :pieces, :piece_move, :integer, default: 0
    remove_column :pieces, :first_move, :boolean
  end
end
