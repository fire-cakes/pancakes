# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Piece, type: :model do
  context 'obstructed?' do
    it 'should return true when there is a piece in the way of a move' do
      g = FactoryGirl.create(:game, :with_two_players, :obstruction)
      p1 = g.pieces.find_by(x_coord: 5, y_coord: 0)
      p2 = g.pieces.find_by(x_coord: 0, y_coord: 0)

      expect(p1.obstructed?(3, 2)).to be true
      expect(p2.obstructed?(0, 3)).to be true
    end
    it 'should return false when there are no pieces in the way of a move' do
      g = FactoryGirl.create(:game, :with_two_players, :obstruction)
      p1 = g.pieces.find_by(x_coord: 0, y_coord: 5)
      p2 = g.pieces.find_by(x_coord: 0, y_coord: 7)

      expect(p1.obstructed?(2, 3)).to be false
      expect(p2.obstructed?(0, 5)).to be false
      expect(p2.obstructed?(2, 7)).to be false
    end
  end

  context 'pos_filled?' do
    it 'should return true if there is a piece at the inputted location' do
      g = FactoryGirl.create(:game, :with_two_players, :populate_board)
      game_id = g.id
      piece = g.pieces.first

      expect(piece.pos_filled?(3, 1, game_id)).to be true
      expect(piece.pos_filled?(5, 5, game_id)).to be false
    end
  end

  context 'colors' do
    it 'white? should return true if color is white' do
      piece = Piece.create(type: 'Pawn', x_coord: 3, y_coord: 3, piece_turn: 0, color: true)
      expect(piece.white?).to be true
    end
    it 'white? should return false if color is black' do
      piece = Piece.create(type: 'Pawn', x_coord: 3, y_coord: 3, piece_turn: 0, color: false)
      expect(piece.white?).to be false
    end
    it 'black? should return true if color is black' do
      piece = Piece.create(type: 'Pawn', x_coord: 3, y_coord: 3, piece_turn: 0, color: false)
      expect(piece.black?).to be true
    end
    it 'black? should return false if color is white' do
      piece = Piece.create(type: 'Pawn', x_coord: 3, y_coord: 3, piece_turn: 0, color: true)
      expect(piece.black?).to be false
    end
    it 'right_color? should return true for black piece on black turns' do
      game = FactoryGirl.create(:game, :with_two_players, :populate_board)
      game.increment_turn
      piece = game.pieces.where(color: false).last

      expect(piece.right_color?).to be true
    end
    it 'right_color? should return true for white piece on white turns' do
      game = FactoryGirl.create(:game, :with_two_players, :populate_board)
      piece = game.pieces.where(color: true).last

      expect(piece.right_color?).to be true
    end
    it 'right_color? should return false for pieces moving when not turn' do
      game = FactoryGirl.create(:game, :with_two_players, :populate_board)
      game.increment_turn
      piece = game.pieces.where(color: true).last

      expect(piece.right_color?).to be false
    end
  end

  context 'occupying_piece' do
    it 'should return the piece at the given location' do
      g = FactoryGirl.create(:game, :with_two_players, :populate_board)
      piece = g.pieces.first

      expect(piece.occupying_piece(3, 7)).to eq(Piece.where(x_coord: 3, y_coord: 7).first)
      expect(piece.occupying_piece(4, 7)).to eq(Piece.where(x_coord: 4, y_coord: 7).first)
    end
  end
end
