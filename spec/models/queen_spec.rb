# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Queen, type: :model do
  context 'valid_move?' do
    it 'should be valid queen moves' do
      # set the variables that need to be checked by the test
      queen = Piece.create(type: 'Queen', x_coord: 4, y_coord: 4)
      # set the matchers to check against a value/true/false
      expect(queen.valid_move?(6, 2)).to be true
      expect(queen.valid_move?(7, 4)).to be true
      expect(queen.valid_move?(2, 4)).to be true
      expect(queen.valid_move?(4, 7)).to be true
      expect(queen.valid_move?(4, 2)).to be true
      expect(queen.valid_move?(4, 4)).to be true
    end

    it 'should be invalid queen moves' do
      queen = Piece.create(type: 'Queen', x_coord: 4, y_coord: 4)
      expect(queen.valid_move?(5, 6)).to be false
      expect(queen.valid_move?(6, 6)).to be false
      expect(queen.valid_move?(2, 2)).to be false
      expect(queen.valid_move?(6, 5)).to be false
      expect(queen.valid_move?(2, 5)).to be false
      expect(queen.valid_move?(5, 2)).to be false
      expect(queen.valid_move?(5, 6)).to be false
      expect(queen.valid_move?(2, 6)).to be false
    end
  end
end
