# frozen_string_literal: true
class Queen < Piece
  def image
    color ? '&#9813;' : '&#9819;'
  end

  def valid_move?(new_x, new_y)
    (x_coord == new_x || y_coord == new_y || (x_coord - new_x).abs == (y_coord - new_y).abs) && super
  end

  def correct_moves
    x0 = x_coord
    y0 = y_coord
    limit = 7
    moves_array = []
    (-limit..limit).each do |_i|
      # rubocop:disable NumericPredicate
      # vertical and horizontal
      4.times do |i|
        if i == 0
          x0 = x_coord + i
          y0 = y_coord
        elsif i == 1
          x0 = x_coord
          y0 = y_coord + i
        else
          # diagonal
          x0 = x_coord + i
          y0 = if i == 2
                 y_coord + i
               else
                 y_coord - i
               end
        end
        moves_array << [x0, y0] unless (x0 == x_coord && y0 == y_coord) || (x0 > 7 || y0 > 7 || x0 < 0 || y0 < 0)
      end
    end
    moves_array
  end
end
