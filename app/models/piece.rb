# frozen_string_literal: true
# This Piece model describes the Piece class and its properties
class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :board

  def self.types
    %w(Pawn Rook Knight Bishop Queen King)
  end

  # rubocop:disable AbcSize, CyclomaticComplexity, PerceivedComplexity
  # x1 and y1 being the destination coordinates
  def obstructed?(x1, y1)
    current_game = Game.find(game_id)
    # starting coordinates
    x0 = x_coord
    y0 = y_coord
    # checks if destination is vertical, horizontal, or diagonal
    x_diff = (x0 - x1).abs
    y_diff = (y0 - y1).abs
    # array keeps list of coordinates of places between origin and destination
    places_between = []
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
        places_between << if x_diff == y_diff
                            [x1, y1]
                          elsif x_diff.zero?
                            [x0, y1]
                          elsif y_diff.zero?
                            [x1, y0]
                          else
                            raise 'Invalid Destination: Move must be diagonal, horizontal, or vertical'
                          end
      end
    end

    # get coordinates for all pieces in current game
    pieces = current_game.pieces.to_a
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

  def valid_move?(new_x, new_y)
    @board_size = 7
    @new_x = new_x
    @new_y = new_y
    # piece cannot move to same position
    unless new_x != @x_coord && new_y != @y_coord
      return false
    end
    # piece cannot move on top of it's own color
    unless new_x != @new_x || new_y != @new_y
      return false
    end
    # piece cannot move off game board
    unless new_x <= @board_size && new_y <= @board_size
      return false
    end
    # no piece can be obstructed
    unless obstructed?(new_x, new_y)
      return false
    end
    true
  end

  # check if the position is filled
  def pos_filled?(x, y)
    pieces.active.where(x_coord: x, y_coord: y).any?
  end

  # return the piece at that location
  def return_piece(x, y)
    pieces.active.find(x_coord: x, y_coord: y)
  end

  # capture the piece
  def capture_piece(x, y)
    game.reset_piece(x, y).update(captured: true)
  end

  def move_to?(new_x, new_y)
    if pos_filled?(new_x, new_y) == true
      if return_piece(new_x, new_y).player_id != current_player
        capture_piece(new_x, new_y)
        update_attributes(x_coord: new_x, y_coord: new_y)
      end
    else
      update_attributes(x_coord: new_x, y_coord: new_y)
    end
  end
end
