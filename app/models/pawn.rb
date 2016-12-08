# frozen_string_literal: true
class Pawn < Piece
  def image
    color ? '&#9817;' : '&#9823;'
  end

  def capture_move?(x, y)
    if occupying_piece(x, y)
      return true if occupying_piece(x, y).color != color
    end
    return true if en_passant?(x, y)
    false
  end

  def valid_move?(x, y)
    # call super
    return false unless super

    # prevent pawn from moving backwards
    return false if white? && (y_coord - y) >= 0
    return false if black? && (y - y_coord) >= 0

    # valid move logic for moving vertically
    if x_coord == x && capture_move?(x, y) == false
      if piece_turn.zero?
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

  def move_to(x, y)
    if en_passant?(x, y)
      opponent_pawn = occupying_piece(x, y_coord)
      opponent_pawn.update_attributes(captured: true)
    end
    super
  end

  def en_passant?(x, _y)
    return false unless (pos_filled_with_other_color?(x_coord + 1, y_coord) && x == (x_coord + 1)) ||
                        (pos_filled_with_other_color?(x_coord - 1, y_coord) && x == (x_coord - 1))
    opponent_pawn = occupying_piece(x, y_coord)
    return false unless opponent_pawn.type == 'Pawn'
    return false unless opponent_pawn.piece_turn == 1
    # Makes sure that the last moved piece by the opponent is the same as the opponent pawn
    last_opponent_piece = game.pieces.where('color = ? and captured = false', !color).order('updated_at').last
    return false unless last_opponent_piece == opponent_pawn
    true
  end
end
