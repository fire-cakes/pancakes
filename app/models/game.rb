# frozen_string_literal: true
class Game < ActiveRecord::Base
  has_many :pieces
  has_one :white_player, class_name: 'Player', foreign_key: 'white_player_id'
  has_one :black_player, class_name: 'Player', foreign_key: 'black_player_id'

  scope :available, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }

  # creates 32 pieces upon start of game with initial x/y coordinates
  def populate_board!
    # white pieces
    # creates the 8 pawn pieces across the board
    8.times do |i|
      # sets game_id in Piece model to current id in Game
      # color is boolean - true for white, false for black
      Pawn.create(game_id: id, x_coord: i, y_coord: 1, color: true, captured: false)
    end
    # creates the 2 rook, knight, and bishop pieces on opposite sides of the board
    (0..7).step(7) do |i|
      Rook.create(game_id: id, x_coord: i, y_coord: 0, color: true, captured: false)
    end
    (1..7).step(5) do |i|
      Knight.create(game_id: id, x_coord: i, y_coord: 0, color: true, captured: false)
    end
    (2..7).step(3) do |i|
      Bishop.create(game_id: id, x_coord: i, y_coord: 0, color: true, captured: false)
    end

    Queen.create(game_id: id, x_coord: 3, y_coord: 0, color: true, captured: false)
    King.create(game_id: id, x_coord: 4, y_coord: 0, color: true, captured: false)

    # black pieces
    8.times do |i|
      Pawn.create(game_id: id, x_coord: i, y_coord: 6, color: false, captured: false)
    end
    (0..7).step(7) do |i|
      Rook.create(game_id: id, x_coord: i, y_coord: 7, color: false, captured: false)
    end
    (1..7).step(5) do |i|
      Knight.create(game_id: id, x_coord: i, y_coord: 7, color: false, captured: false)
    end
    (2..7).step(3) do |i|
      Bishop.create(game_id: id, x_coord: i, y_coord: 7, color: false, captured: false)
    end
    Queen.create(game_id: id, x_coord: 3, y_coord: 7, color: false, captured: false)
    King.create(game_id: id, x_coord: 4, y_coord: 7, color: false, captured: false)
  end

  def increment_turn
    update_attribute(:turn, turn + 1)
  end

  def white_turn?
    turn.odd?
  end

  def black_turn?
    turn.even?
  end

  def current_turn
    if white_turn?
      'white'
    else
      'black'
    end
  end

  def player_color(*)
    return true if white_turn?
    return false if black_turn?
  end

  def check?(player_color)
    king = pieces.find_by(type: 'King', color: player_color)
    result = false
    # array of opponent pieces still on the board
    opponent_pieces = uncaptured_pieces(!player_color)
    opponent_pieces.each do |p|
      next unless p.valid_move?(king.x_coord, king.y_coord)
      @checking_piece = p
      result = true
    end
    result
  end

  def show_checking_piece
    "#{@checking_piece.type} (#{@checking_piece.x_coord}, #{@checking_piece.y_coord})"
  end

  # return an array of pieces that are still on the board
  def uncaptured_pieces(player_color)
    pieces.includes(:game).where('color = ? and captured = false', player_color).to_a
  end

  def checkmate?(player_color)
    king = pieces.find_by(type: 'King', color: player_color)
    # check that the player is in check
    return false unless check?(player_color)
    # check if there is another piece that can capture the checking piece
    return false if @checking_piece.capturable?
    # check if another player piece can block the checking piece
    return false if @checking_piece.block_check?(king)
    # check if the king is able to move itself out of check
    return false if king.move_out_of_check?

    true
  end

  def stalemate?(player_color)
    # checks if the player is in check
    return false if check?(player_color)
    # check if any legal moves are available without going into check for remaining pieces
    uncaptured_pieces(player_color).each do |piece|
      # only takes one legal move to return stalemate false
      return false if piece.move_out_of_check?
    end
    true
  end

  def full?
    white_player_id.present? && black_player_id.present?
  end
end
