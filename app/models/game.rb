# frozen_string_literal: true
class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :white_player
  belongs_to :black_player

  after_create :populate_board!
  # creates 32 pieces upon start of game with initial x/y coordinates
  # rubocop:disable AbcSize
  def populate_board!
    # white pieces
    # creates the 8 pawn pieces across the board
    8.times do |i|
      # sets game_id in Piece model to current id in Game
      # color is boolean - true for white, false for black
      Pawn.create(game_id: id, x_coord: i, y_coord: 1, color: true)
    end
    # creates the 2 rook, knight, and bishop pieces on opposite sides of the board
    (0..7).step(7) do |i|
      Rook.create(game_id: id, x_coord: i, y_coord: 0, color: true)
    end
    (1..7).step(5) do |i|
      Knight.create(game_id: id, x_coord: i, y_coord: 0, color: true)
    end
    (2..7).step(3) do |i|
      Bishop.create(game_id: id, x_coord: i, y_coord: 0, color: true)
    end

    Queen.create(game_id: id, x_coord: 3, y_coord: 0, color: true)
    King.create(game_id: id, x_coord: 4, y_coord: 0, color: true)

    # black pieces
    8.times do |i|
      Pawn.create(game_id: id, x_coord: i, y_coord: 6, color: false)
    end
    (0..7).step(7) do |i|
      Rook.create(game_id: id, x_coord: i, y_coord: 7, color: false)
    end
    (1..7).step(5) do |i|
      Knight.create(game_id: id, x_coord: i, y_coord: 7, color: false)
    end
    (2..7).step(3) do |i|
      Bishop.create(game_id: id, x_coord: i, y_coord: 7, color: false)
    end
    Queen.create(game_id: id, x_coord: 3, y_coord: 7, color: false)
    King.create(game_id: id, x_coord: 4, y_coord: 7, color: false)
  end
end
