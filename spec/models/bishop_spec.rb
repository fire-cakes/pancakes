# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Bishop, type: :model do
  context 'valid_move?' do
    it 'should be valid bishop moves' do
      # set the variables that need to be checked by the test
      bishop = Piece.create(type: 'Bishop', x_coord: 4, y_coord: 4)
      # set the matchers to check against a value/true/false
      expect(bishop.valid_move?(6, 6)). to be true
      expect(bishop.valid_move?(2, 2)). to be true
      expect(bishop.valid_move?(2, 6)). to be true
      expect(bishop.valid_move?(6, 2)). to be true
    end

    it 'should be invalid bishop moves' do
      bishop = Piece.create(type: 'Bishop', x_coord: 4, y_coord: 4)
      expect(bishop.valid_move?(7, 4)).to be false
      expect(bishop.valid_move?(2, 4)).to be false
      expect(bishop.valid_move?(4, 7)).to be false
      expect(bishop.valid_move?(4, 2)).to be false
      expect(bishop.valid_move?(6, 5)).to be false
      expect(bishop.valid_move?(2, 5)).to be false
    end
  end
end
