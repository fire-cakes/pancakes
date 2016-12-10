# frozen_string_literal: true
class Rook < Piece
  def image
    color ? '&#9814;' : '&#9820;'
  end

  def valid_move?(new_x, new_y)
    return true if (new_x == x_coord || new_y == y_coord) && super
    false
  end

  def correct_moves
    x0 = x_coord
    y0 = y_coord
    limit = 7
    moves_array = []
    (-limit..limit).each do |i|
      # rubocop:disable NumericPredicate
      x0 = x_coord + i
      y0 = y_coord
      moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
      x0 = x_coord
      y0 = y_coord + i
      moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
    end
    moves_array
  end
end
