# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Knight, type: :model do
  context 'valid_move?' do
    it 'allows valid knight moves' do
      knight = Piece.create(type: 'Knight', x_coord: 4, y_coord: 4)
      expect(knight.valid_move?(6, 5)).to be true
      expect(knight.valid_move?(2, 5)).to be true
      expect(knight.valid_move?(5, 2)).to be true
      expect(knight.valid_move?(5, 6)).to be true
    end

    it 'does not allow invalid knight moves' do
      knight = Piece.create(type: 'Knight', x_coord: 4, y_coord: 4)
      # horizontal move
      expect(knight.valid_move?(3, 4)).to be false
      # vertical move
      expect(knight.valid_move?(4, 6)).to be false
      # diagonal move
      expect(knight.valid_move?(6, 6)).to be false
    end
  end
end
