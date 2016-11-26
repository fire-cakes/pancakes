# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pawn, type: :model do
  context 'valid_move?' do
    it 'allows valid vertical pawn move when first move' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, first_move: true, color: true)
      expect(pawn.valid_move?(4, 3)).to be true
      expect(pawn.valid_move?(4, 4)).to be true
    end

    it 'does not allow invalid vertical pawn move when first move' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, first_move: true, color: true)
      expect(pawn.valid_move?(4, 5)).to be false
      expect(pawn.valid_move?(4, 6)).to be false
    end

    it 'allows valid diagonal move' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, first_move: true, color: true)
      g.pieces.create(type: 'Queen', x_coord: 3, y_coord: 3, first_move: true, color: false)
      expect(pawn.valid_move?(3, 3)).to be true
    end

    it 'does not allow other invalid moves' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 2, first_move: true, color: true)
      g.pieces.create(type: 'Pawn', x_coord: 3, y_coord: 3, first_move: true, color: true)
      expect(pawn.valid_move?(3, 2)).to be false
      expect(pawn.valid_move?(2, 7)).to be false
      expect(pawn.valid_move?(3, 3)).to be false
      expect(pawn.valid_move?(4, 6)).to be false
    end
  end

  context 'promote' do
    it 'allows promotion of pawn to another piece' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      pawn = g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 6, color: true)
      puts "Enter letter 'q' for rspec test to pass, an invalid letter to get reprompt, and 'r', 'b', or 'k' to fail."
      pawn.promote(7)
      expect(pawn.type).to eq('Queen')
    end
  end
end
