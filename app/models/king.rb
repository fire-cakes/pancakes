# frozen_string_literal: true
class King < Piece
  def image
    color ? '&#9812;' : '&#9818;'
  end

  def valid_move?(new_x, new_y)
    y_distance = (new_y - y_coord).abs
    x_distance = (new_x - x_coord).abs
    return true if (y_distance <= 1 && x_distance <= 1) && super
    false
  end

  def correct_moves
    x0 = x_coord
    y0 = y_coord
    limit = 1
    moves_array = []
    # x-direction
    (-limit..limit).each do |i|
      x0 = x_coord + i
      # y- direction
      (-limit..limit).each do |j|
        y0 = y_coord + j
        moves_array << [x0, y0] unless x0 == x_coord && y0 == y_coord
      end
    end
    moves_array
  end
end
