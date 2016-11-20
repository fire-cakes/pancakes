# frozen_string_literal: true
class Pawn < Piece
  def image
    color ? '&#9817;' : '&#9823;'
  end

  def capture_move?(x, y)
    piece = return_piece(x, y)
    if piece.nil?
      return false
    elsif piece.color == color
      return false
    else 
      return true
    end
  end

  def valid_move?(x, y)
    # call super 
    # return false unless super

    # prevent pawn from moving backwards
    return false if white? && (y_coord - y) >= 0
    return false if black? && (y - y_coord) >= 0

    # valid move logic for moving vertically
    if x_coord == x
      if first_move
        if (y - y_coord).abs < 3
          return true
        else
          return false
        end
      elsif (y - y_coord).abs < 2
        return true
      else
        return false
      end
    end

    # valid move logic for moving diagonal capturing a piece
    if ((x - x_coord).abs == 1) && ((y - y_coord).abs == 1)
      return true
    else
      false
      # if capture_move?(x, y)
      #   return true
      # else
      #   return false
      # end
    end

    false
  end
end
