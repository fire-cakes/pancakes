# frozen_string_literal: true
class Knight < Piece
  def image
    color ? '&#9816;' : '&#9822;'
  end

  def valid_move?(x1, y1)
    return false if x_coord == x1
    return false if y_coord == y1
    proper_length?(x1, y1)
  end

  def proper_length?(x1, y1)
    (x_coord - x1).abs + (y_coord - y1).abs == 3
  end

  def obstructed?(x, y)
    false
  end
end
