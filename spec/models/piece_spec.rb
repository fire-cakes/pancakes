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
    it 'should return an error if the move is not a vertical, horizontal, or diagonal move' do
      g = FactoryGirl.create(:game, :with_two_players, :obstruction)
      p = g.pieces.find_by(x_coord: 3, y_coord: 3)

      expect { p.obstructed?(1, 4) }.to raise_error(RuntimeError)
    end
  end

  context 'pos_filled?' do
    it 'should return true if there is a piece at the inputted location' do
      piece = Piece.create(type: 'Pawn', x_coord: 3, y_coord: 3, first_move: true, color: false)
      Piece.create(type: 'Pawn', x_coord: 3, y_coord: 7, first_move: true, color: false)
      expect(piece.pos_filled?(3, 7)).to be true
      expect(piece.pos_filled?(4, 7)).to be false
    end
  end

  context 'return_piece' do
    it 'should return the piece at the given location' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      piece = g.pieces.create(type: 'Pawn', x_coord: 3, y_coord: 3, first_move: true, color: false, player_id: 1)
      g.pieces.create(type: 'Pawn', x_coord: 3, y_coord: 7, first_move: true, color: false, player_id: 2)
      g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 7, first_move: true, color: true, player_id: 2)
      expect(piece.return_piece(3, 7) == Piece.where(x_coord: 3, y_coord: 7)).to be true
      expect(piece.return_piece(4, 7) == Piece.where(x_coord: 4, y_coord: 7)).to be true
      expect(piece.return_piece(3, 1) == Piece.where(x_coord: 3, y_coord: 1)).to be false
    end
  end
end
