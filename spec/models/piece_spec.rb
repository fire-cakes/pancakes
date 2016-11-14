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
    it "should return false when there are no pieces in the way of a move" do
      g = FactoryGirl.create(:game, :with_two_players, :obstruction)
      p1 = g.pieces.find_by(x_coord: 0, y_coord: 5)
      p2 = g.pieces.find_by(x_coord: 0, y_coord: 7)
      p3 = g.pieces.find_by(x_coord: 3, y_coord: 3)
      
      expect(p3.obstructed?(1, 4)).to be true
      expect(p1.obstructed?(2, 3)).to be false
      expect(p2.obstructed?(0, 5)).to be false
      expect(p2.obstructed?(2, 7)).to be false
    end
  end
end
