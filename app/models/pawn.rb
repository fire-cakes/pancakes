# frozen_string_literal: true
class Pawn < Piece
  def image
    color ? '&#9817;' : '&#9823;'
  end

  def capture_move?(x, y)
    piece = return_piece(x, y)
    if piece.nil?
      return false
    elsif piece.user_id == current_user
      return false
    else 
      return true
    end
  end

  def valid_move?(x, y)
    call super and obstructed methods
    return false unless super(x, y)
    return false if obstructed?(x, y)

    # prevent pawn from moving backwards
    return false if white? && (y_coord - y).positive?
    return false if black? && (y - y_coord).positive?

    # valid move logic for moving vertically
    if x_coord == x
      if first_move?
        if return_piece(x, y).nil? && (x - x_coord).abs < 3
          return true
        else
          return false
        end
      elsif return_piece(x, y).nil? && (x - x_coord).abs < 2
        return true
      else
        return false
      end
    end

    # valid move logic for capturing a piece
    if ((x - x_coord).abs == 1) && ((y - y_coord).abs == 1)
      if capture_move?(x, y)
        return true
      else
        return false
      end
    end

    false
  end

end
