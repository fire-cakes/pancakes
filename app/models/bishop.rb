# frozen_string_literal: true
class Bishop < Piece
  def image
    color ? '&#9815;' : '&#9821;'
  end

  def valid_move?(new_x, new_y)
    x_dist = (x_coord - new_x).abs
    y_dist = (y_coord - new_y).abs
    return true if x_dist == y_dist
    false
  end
end
