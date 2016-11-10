# frozen_string_literal: true
class Rook < Piece
  def image
    color ? '&#9814;' : '&#9820;'
  end

  def valid_move?(new_x, new_y)
    return true if new_x == x_coord || new_y == y_coord
    false
  end
end
