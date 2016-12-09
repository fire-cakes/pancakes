# frozen_string_literal: true
# This Piece model describes the Piece class and its properties
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :board

  def self.types
    %w(Pawn Rook Knight Bishop Queen King)
  end

  def attempt_move(x, y)
    # ensure integers
    x = x.to_i
    y = y.to_i

    Piece.transaction do
      return false unless game.full? # ensure two players before move
      return false unless right_color? # ensure same color as turn
      return false unless valid_move?(x, y) # ensure move is legal

      # TODO: fail ActiveRecord::Rollback if game.check?(color) # stop move if in check
      # TODO fail ActiveRecord::Rollback if obstructed?

      move_to(x, y)
      reload
      raise ActiveRecord::Rollback if game.check?(color) # ensure that move does not result in check

      game.increment_turn
      # TODO: update game status if appropriate...?
    end
  end

  # x1 and y1 being the destination coordinates
  def obstructed?(x1, y1)
    current_coordinates = [x_coord, y_coord]
    x_diff = (x_coord - x1).abs
    y_diff = (y_coord - y1).abs
    places_between = squares_between(x1, y1)
    # get coordinates for all pieces in current game
    pieces = game.pieces.to_a
    all_piece_coordinates = pieces.map { |p| [p.x_coord, p.y_coord] }
    # check if any pieces on board conflict with the coordinates between origin and destination piece position
    obstruction = false
    all_piece_coordinates.each do |piece_coordinates|
      is_current_piece = current_coordinates == piece_coordinates
      is_destination_piece = piece_coordinates == [x1, y1]

      obstruction = true if x_diff.zero? && y_diff.zero?

      obstruction = true if places_between.include?(piece_coordinates) && !is_current_piece && !is_destination_piece
    end
    obstruction
  end

  # return an array of squares between player's piece and destination coordinate
  def squares_between(x1, y1)
    # starting coordinates
    x0 = x_coord
    y0 = y_coord
    # checks if destination is vertical, horizontal, or diagonal
    x_diff = (x0 - x1).abs
    y_diff = (y0 - y1).abs
    # array keeps list of coordinates of places between origin and destination
    places_arr = []
    current_coordinates = [x0, y0]
    back_to_start = false
    # iterates through each places in between origin and destination
    until back_to_start
      if x1 > x0
        x1 -= 1
      elsif x1 < x0
        x1 += 1
      end

      if y1 > y0
        y1 -= 1
      elsif y1 < y0
        y1 += 1
      end

      if current_coordinates == [x1, y1]
        back_to_start = true
      else
        places_arr << if x_diff == y_diff
                        [x1, y1]
                      elsif x_diff.zero?
                        [x0, y1]
                      elsif y_diff.zero?
                        [x1, y0]
                      end
      end
    end
    places_arr
  end

  def valid_move?(new_x, new_y)
    board_size = 7
    # piece cannot move to same position
    return false if new_x == x_coord && new_y == y_coord
    # rubocop:disable NumericPredicate
    # piece cannot move off game board
    return false if new_x > board_size || new_y > board_size || new_x < 0 || new_y < 0
    # move cannot be obstructed by another piece
    return false if obstructed?(new_x, new_y)
    # ensures no piece of same color
    return false if pos_filled_with_same_color?(new_x, new_y)
    true
  end

  # check if white piece
  def white?
    color
  end

  # check if black piece
  def black?
    !color
  end

  # check if moving piece matches turn's color
  def right_color?
    white? && game.white_turn? || black? && game.black_turn?
  end

  def owner
    return game.white_player_id if white?
    return game.black_player_id if black?
  end

  # check if the position is filled
  def pos_filled?(x, y, _game_id = game.id)
    Piece.where(x_coord: x, y_coord: y, captured: false, game: game.id).any?
  end

  def pos_filled_with_other_color?(x, y)
    other_piece = Piece.find_by(x_coord: x, y_coord: y, captured: false, game_id: game_id)

    return false if other_piece.nil?
    return true if other_piece.color != color

    false
  end

  def pos_filled_with_same_color?(x, y)
    other_piece = Piece.find_by(x_coord: x, y_coord: y, captured: false, game_id: game_id)

    return false if other_piece.nil?

    return true if other_piece.color == color

    false
  end

  # return the piece at that location
  def occupying_piece(x, y)
    return game.pieces.find_by(x_coord: x, y_coord: y) if game.pieces.find_by(x_coord: x, y_coord: y).present?
  end

  # capture the piece
  def capture_piece(x, y)
    captured_piece = game.pieces.find_by(x_coord: x, y_coord: y)
    captured_piece.update_attributes(captured: true, x_coord: nil, y_coord: nil)
  end

  def move_to(x, y)
    capture_piece(x, y) if pos_filled?(x, y)
    update_attributes(x_coord: x, y_coord: y, piece_turn: piece_turn + 1)
  end

  # def move_into_check?(new_x, new_y)
  #   x0 = x_coord
  #   y0 = y_coord
  #   # call check? to determine if move will result in a check
  #   update_attributes(x_coord: new_x, y_coord: new_y)
  #   return game.check?(color)
  #   # reset possible moves to starting position
  #   update_attributes(x_coord: x0, y_coord: y0)
  # end

  # /// checkmate helpers ///
  # return true if opponent's checking piece can be captured by player
  def capturable?
    opponent_pieces = game.uncaptured_pieces(!color)
    opponent_pieces.each do |piece|
      if piece.valid_move?(x_coord, y_coord)
        return true
      end
    end
    false
  end

  # return true if a player's piece is able to block a check
  def block_check?(king)
    # array of coordinates between the king and the checking piece
    check_squares = squares_between(king.x_coord, king.y_coord)
    return false if check_squares == [nil, nil]
    potential_blockers = game.uncaptured_pieces(king.color)
    potential_blockers.each do |piece|
      next if piece.type == 'King'
      check_squares.each do |square|
        return true if piece.valid_move?(square[0], square[1])
      end
    end
    false
  end
  # ////////////////////////////
end
