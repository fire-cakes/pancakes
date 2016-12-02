# frozen_string_literal: true
class Pawn < Piece
  def image
    color ? '&#9817;' : '&#9823;'
  end

  def capture_move?(x, y)
    if occupying_piece(x, y)
      return true if occupying_piece(x, y).color != color
    end
    return true if en_passant?(x,y)
    false
  end


  def valid_move?(x, y)
    # call super
    return false unless super

    # prevent pawn from moving backwards
    return false if white? && (y_coord - y) >= 0
    return false if black? && (y - y_coord) >= 0

    # valid move logic for moving vertically
    if x_coord == x
      if piece_turn == 0
        return true if (y - y_coord).abs < 3
        false
      elsif (y - y_coord).abs < 2
        return true
      else
        return false
      end
    end

    # valid move logic for moving diagonal capturing a piece
    if ((x - x_coord).abs == 1) && ((y - y_coord).abs == 1)
      return capture_move?(x, y)
    end
    false
  end
  
  def en_passant?(x, y)
    y_diff = (y_coord - y).abs
    return false unless (pos_filled_with_other_color?(x_coord + 1, y_coord) && x == (x_coord + 1)) || (pos_filled_with_other_color?(x_coord - 1, y_coord) && x == (x_coord - 1))
    opponent_pawn = occupying_piece(x, y_coord)
    return false unless opponent_pawn.piece_turn == 1
    # TODO: a condition to return false when the opponent's last move did not involve the opponent pawn
    true
    
  end
end
