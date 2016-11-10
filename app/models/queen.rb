# frozen_string_literal: true
class Queen < Piece
  def image
    color ? '&#9813;' : '&#9819;'
  end

  def valid_move?(new_x, new_y)
    x_distance = (x_coord - new_x).abs
    y_distance = (y_coord - new_y).abs
    if super
      return true
    end
    unless x_coord == new_x
      return false
    end
    unless y_coord == new_y
      return false
    end
    unless x_distance == y_distance
      return false
    end
    true
  end
end
