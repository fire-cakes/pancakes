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

  def obstructed?(_x, _y)
    false
  end

  def correct_moves
    x0 = x_coord
    y0 = y_coord
    limit = 3
    moves_array = []
    # x-direction
    (-limit..limit).each do |i|
      x0 = x_coord + i
      # y- direction
      (-limit..limit).each do |j|
        y0 = y_coord + j
        if valid_move?(x0, y0)
          # rubocop:disable NumericPredicate
          moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
        end
      end
    end
    moves_array
  end
end
