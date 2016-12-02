# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pawn, type: :model do
  context 'valid_move?' do
    it 'allows valid vertical pawn move when first move' do
      g = FactoryGirl.create(:game, :with_two_players)
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, piece_turn: 0, color: true)
      expect(pawn.valid_move?(4, 3)).to be true
      expect(pawn.valid_move?(4, 4)).to be true
    end

    it 'does not allow invalid vertical pawn move when first move' do
      g = FactoryGirl.create(:game, :with_two_players)
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, piece_turn: 0, color: true)
      expect(pawn.valid_move?(4, 5)).to be false
      expect(pawn.valid_move?(4, 6)).to be false
    end

    it 'allows valid diagonal move' do
      g = FactoryGirl.create(:game, :with_two_players)
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, piece_turn: 0, color: true)
      g.pieces.create(type: 'Queen', x_coord: 3, y_coord: 3, piece_turn: 0, color: false)

      expect(pawn.valid_move?(3, 3)).to be true
    end

    it 'does not allow other invalid moves' do
      g = FactoryGirl.create(:game, :with_two_players)
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, piece_turn: 0, color: true)
      g.pieces.create(type: 'Pawn', x_coord: 3, y_coord: 3, piece_turn: 0, color: true)
      expect(pawn.valid_move?(3, 2)).to be false
      expect(pawn.valid_move?(2, 7)).to be false
      expect(pawn.valid_move?(3, 3)).to be false
      expect(pawn.valid_move?(4, 6)).to be false
    end
  end
  
  context 'en_passant?' do
    it 'returns true when a pawn is a valid en passant capture' do
      g = FactoryGirl.create(:game, :with_two_players)
      # black's turn (even) to attempt en passant capture on white pawn
      g.turn = 6
      pawn = g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 3, piece_turn: 2, color: false)
      g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 3, piece_turn: 1, color: true)
      g.pieces.create(type: 'Pawn', x_coord: 2, y_coord: 3, piece_turn: 1, color: true)
      
      expect(pawn.en_passant?(0, 2)).to be true
      expect(pawn.en_passant?(2, 2)).to be true
    end
    
    it " returns false when the opponent's pawn did not move forward two ranks from its starting position" do
      g = FactoryGirl.create(:game, :with_two_players)
      # black's turn (even) to attempt en passant capture on white pawn
      g.turn = 6
      pawn = g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 3, piece_turn: 2, color: false)
      g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 2, piece_turn: 1, color: true)
      
      expect(pawn.en_passant?(0, 2)).to be false
    end
    
    it "returns false when the opponent's pawn is not on its first move" do
      g = FactoryGirl.create(:game, :with_two_players)
      # black's turn (even) to attempt en passant capture on white pawn
      g.turn = 6
      pawn = g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 3, piece_turn: 2, color: false)
      g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 3, piece_turn: 2, color: true)
      g.pieces.create(type: 'Pawn', x_coord: 2, y_coord: 3, piece_turn: 2, color: true)
      
      expect(pawn.en_passant?(0, 2)).to be false
      expect(pawn.en_passant?(2, 2)).to be false
    end
    
    it "returns false when the opponent's last move did not utilize the pawn to be captured" do
      g = FactoryGirl.create(:game, :with_two_players)
      # black's turn (even) to attempt en passant capture on white pawn
      g.turn = 5
      pawn = g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 3, piece_turn: 2, color: false)
      g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 3, piece_turn: 1, color: true)
      g.pieces.create(type: 'Pawn', x_coord: 2, y_coord: 3, piece_turn: 1, color: true)
      not_pawn = g.pieces.create(type: 'Bishop', x_coord: 0, y_coord: 6, piece_turn: 1, color: true)
      not_pawn.move_to(2,4)
      game.increment_turn
      
      expect(pawn.en_passant?(0, 2)).to be false
      expect(pawn.en_passant?(2, 2)).to be false
    end
    
    
  end
end
