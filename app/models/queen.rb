# frozen_string_literal: true
class Queen < Piece
  def image
    color ? '&#9813;' : '&#9819;'
  end

  def valid_move?(new_x, new_y)
    x_coord == new_x || y_coord == new_y ||
      (x_coord - new_x).abs == (y_coord - new_y).abs
  end
end
