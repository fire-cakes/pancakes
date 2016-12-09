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
    piece = Piece.find(id)
    x0 = piece.x_coord
    y0 = piece.y_coord

    # available moves for king
    up = [x0, y0 + 1]
    down = [x0, y0 - 1]
    right = [x0 + 1, y0]
    left = [x0 - 1, y0]

    valid_moves = []

    # valid move only if
    move_up = y0 != 7
    move_down = y0.nonzero?
    move_left = x0.nonzero?
    move_right = x0 != 7

    valid_moves.push(up) if move_up
    valid_moves.push(down) if move_down
    valid_moves.push(left) if move_left
    valid_moves.push(right) if move_right

    valid_moves
  end

  # this method does not care whether or not game state is currently in check
  def move_out_of_check?
    x0 = x_coord
    y0 = y_coord
    correct_moves.each do |move|
      # call check? to determine if any available valid move is able to get king out of check
      if valid_move?(move[0], move[1])
        update_attributes(x_coord: move[0], y_coord: move[1])
        return true unless game.check?(color)
        # reset possible moves to starting position
        update_attributes(x_coord: x0, y_coord: y0)
      end
    end
    false
  end
end
