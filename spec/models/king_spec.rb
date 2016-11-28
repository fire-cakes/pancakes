# frozen_string_literal: true
require 'rails_helper'

RSpec.describe King, type: :model do
  context 'valid_move?' do
    it 'should be valid king moves' do
      # set the variables that need to be checked by the test
      g = FactoryGirl.create(:game, :with_two_players)
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 4)
      expect(king.valid_move?(4, 4)).to be false
      expect(king.valid_move?(3, 4)).to be true
      expect(king.valid_move?(4, 5)).to be true
      expect(king.valid_move?(4, 3)).to be true
      expect(king.valid_move?(5, 5)).to be true
    end

    it 'should be invalid king moves' do
      g = FactoryGirl.create(:game, :with_two_players)
      king = g.pieces.create(type: 'King', x_coord: 4, y_coord: 4)

      expect(king.valid_move?(5, 7)).to be false
      expect(king.valid_move?(7, 4)).to be false
      expect(king.valid_move?(2, 4)).to be false
      expect(king.valid_move?(4, 7)).to be false
      expect(king.valid_move?(4, 2)).to be false
    end
  end
end
