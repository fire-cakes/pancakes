# frozen_string_literal: true
require 'rails_helper'

RSpec.describe King, type: :model do
  context 'valid_move?' do
    it 'should be valid king moves' do
      # set the variables that need to be checked by the test
      g = FactoryGirl.create(:game, :with_two_players)
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 4, first_move: false)
      expect(king.valid_move?(4, 4)).to be false
      expect(king.valid_move?(3, 4)).to be true
      expect(king.valid_move?(4, 5)).to be true
      expect(king.valid_move?(4, 3)).to be true
      expect(king.valid_move?(5, 5)).to be true
    end

    it 'should be invalid king moves' do
      g = FactoryGirl.create(:game, :with_two_players)
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 4, first_move: false)

      expect(king.valid_move?(5, 7)).to be false
      expect(king.valid_move?(7, 4)).to be false
      expect(king.valid_move?(2, 4)).to be false
      expect(king.valid_move?(4, 7)).to be false
      expect(king.valid_move?(4, 2)).to be false
    end
  end

  context 'castling?' do
    it "allows castling when requirements met" do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 0, first_move: true, color: true)
      rook = g.pieces.create(type: 'Rook', x_coord: 7, y_coord: 0, first_move: true, color: true)
      king.castling?(6, 0)
      rook.reload
      expect(king.x_coord).to eq(6)
      expect(rook.x_coord).to eq(5)
    end

    it "allows castling when requirements met" do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 7, first_move: true, color: false)
      rook = g.pieces.create(type: 'Rook', x_coord: 0, y_coord: 7, first_move: true, color: false)
      king.castling?(2, 7)
      rook.reload
      expect(king.x_coord).to eq(2)
      expect(rook.x_coord).to eq(3)
    end

    it "doesn't allow castling when requirements met" do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.destroy_all
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 0, first_move: true, color: true)
      rook = g.pieces.create(type: 'Rook', x_coord: 7, y_coord: 0, first_move: true, color: true)
      king.castling?(5, 0)
      rook.reload
      expect(king.x_coord).to eq(4)
      expect(rook.x_coord).to eq(7)
    end
  end
end
