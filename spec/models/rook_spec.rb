# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Rook, type: :model do
  context 'valid_move?' do
    it 'should be valid rook moves' do
      # set the variables that need to be checked by the test
      g = FactoryGirl.create(:game, :with_two_players)
      rook = g.pieces.create(type: 'Rook', x_coord: 4, y_coord: 4)

      # set the matchers to check against a value/true/false
      expect(rook.valid_move?(7, 4)).to be true
      expect(rook.valid_move?(2, 4)).to be true
      expect(rook.valid_move?(4, 7)).to be true
      expect(rook.valid_move?(4, 2)).to be true
    end

    it 'should be invalid rook moves' do
      rook = Piece.create(type: 'Rook', x_coord: 4, y_coord: 4)

      expect(rook.valid_move?(5, 5)).to be false
      expect(rook.valid_move?(5, 6)).to be false
    end
  end
end
