# frozen_string_literal: true
class Bishop < Piece
  def image
    color ? '&#9815;' : '&#9821;'
  end

  def valid_move?(new_x, new_y)
    x_dist = (x_coord - new_x).abs
    y_dist = (y_coord - new_y).abs
    return true if x_dist == y_dist && super
    false
  end

  def correct_moves
    x0 = x_coord
    y0 = y_coord
    limit = 7
    moves_array = []
    (-limit..limit).each do |i|
      x0 = x_coord + i
      y0 = y_coord + i
      moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
      x0 = x_coord + i
      y0 = y_coord - i
      moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
    end
    moves_array
  end
end
