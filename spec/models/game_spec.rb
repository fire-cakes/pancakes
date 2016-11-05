# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Game, type: :model do
    context "populate_board!" do
        it "creates 32 starting pieces on a new game start" do
            g = Game.create
            expect(g.pieces.count).to eq(32)
        end
        it "creates the pieces in the correct starting coordinates" do
            g = Game.create
            #the correct starting positions for pawns
            pawns_arr = [[0, 1, true], [1, 1, true], [2, 1, true], [3, 1, true], [4, 1, true], [5, 1, true], [6, 1, true], [7, 1, true],
                        [0, 6, false], [1, 6, false], [2, 6, false], [3, 6, false], [4, 6, false], [5, 6, false], [6, 6, false], [7, 6, false]]
            #pawns created in Game model
            pawns_game = g.pieces.where(:type => 'Pawn').pluck(:x_coord, :y_coord, :color)
            
            rooks_arr = [[0, 0, true], [7, 0, true],
                        [0, 7, false], [7, 7, false]]
            rooks_game = g.pieces.where(:type => 'Rook').pluck(:x_coord, :y_coord, :color)
            
            knights_arr = [[1, 0, true], [6, 0, true],
                          [1, 7, false], [6, 7, false]]
            knights_game = g.pieces.where(:type => 'Knight').pluck(:x_coord, :y_coord, :color)
            
            bishops_arr = [[2, 0, true], [5, 0, true],
                          [2, 7, false], [5, 7, false]]
            bishops_game = g.pieces.where(:type => 'Bishop').pluck(:x_coord, :y_coord, :color)
            
            queens_arr = [[3, 0, true],
                         [3, 7, false]]
            queens_game = g.pieces.where(:type => 'Queen').pluck(:x_coord, :y_coord, :color)
            
            kings_arr = [[4, 0, true],
                        [4, 7, false]]
            kings_game = g.pieces.where(:type => 'King').pluck(:x_coord, :y_coord, :color)
                          
            expect(pawns_game).to match_array pawns_arr
            expect(rooks_game).to match_array rooks_arr
            expect(knights_game).to match_array knights_arr
            expect(bishops_game).to match_array bishops_arr
            expect(queens_game).to match_array queens_arr
            expect(kings_game).to match_array kings_arr
            
        end
    end
end
