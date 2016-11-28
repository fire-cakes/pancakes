# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'populate_board!' do
    it 'creates 32 starting pieces on a new game start' do
      g = FactoryGirl.create(:game, :populate_board)
      expect(g.pieces.count).to eq(32)
    end
    it 'creates the pieces in the correct starting coordinates' do
      g = FactoryGirl.create(:game, :populate_board)
      # the correct starting positions for pawns
      pawns_arr = [[0, 1, true], [1, 1, true], [2, 1, true], [3, 1, true],
                   [4, 1, true], [5, 1, true], [6, 1, true], [7, 1, true],
                   [0, 6, false], [1, 6, false], [2, 6, false], [3, 6, false],
                   [4, 6, false], [5, 6, false], [6, 6, false], [7, 6, false]]
      # pawns created in Game model
      pawns_game = g.pieces.where(type: 'Pawn').pluck(:x_coord, :y_coord, :color)

      rooks_arr = [[0, 0, true], [7, 0, true],
                   [0, 7, false], [7, 7, false]]
      rooks_game = g.pieces.where(type: 'Rook').pluck(:x_coord, :y_coord, :color)

      knights_arr = [[1, 0, true], [6, 0, true],
                     [1, 7, false], [6, 7, false]]
      knights_game = g.pieces.where(type: 'Knight').pluck(:x_coord, :y_coord, :color)

      bishops_arr = [[2, 0, true], [5, 0, true],
                     [2, 7, false], [5, 7, false]]
      bishops_game = g.pieces.where(type: 'Bishop').pluck(:x_coord, :y_coord, :color)

      queens_arr = [[3, 0, true],
                    [3, 7, false]]
      queens_game = g.pieces.where(type: 'Queen').pluck(:x_coord, :y_coord, :color)

      kings_arr = [[4, 0, true],
                   [4, 7, false]]
      kings_game = g.pieces.where(type: 'King').pluck(:x_coord, :y_coord, :color)

      expect(pawns_game).to match_array pawns_arr
      expect(rooks_game).to match_array rooks_arr
      expect(knights_game).to match_array knights_arr
      expect(bishops_game).to match_array bishops_arr
      expect(queens_game).to match_array queens_arr
      expect(kings_game).to match_array kings_arr
    end
  end

  context 'turns' do
    it 'increments by one' do
      game = FactoryGirl.create(:game, :with_two_players)
      expect(game.turn).to be(1)
      game.increment_turn
      expect(game.turn).to be(2)
      game.increment_turn
      expect(game.turn).to be(3)
    end
    it 'odd turns are white' do
      game = FactoryGirl.create(:game, :with_two_players)
      expect(game.white_turn?).to be true
      expect(game.black_turn?).to be false
    end
    it 'even turns are black' do
      game = FactoryGirl.create(:game, :with_two_players)
      game.increment_turn
      expect(game.black_turn?).to be true
      expect(game.white_turn?).to be false
    end
  end

  context 'scopes' do
    it 'avaliable returns avaliable games' do
      g = FactoryGirl.create(:game, :with_one_player)
      avaliable_games = Game.available

      expect(avaliable_games).to include(g)
    end

    it 'returns nil when all games have two players' do
      FactoryGirl.create(:game, :with_two_players)
      avaliable_games = Game.available

      expect(avaliable_games.any?).to be_falsey
    end
  end

  context 'full?' do
    it 'returns true when there are two players' do
      g = FactoryGirl.create(:game, :with_two_players)

      expect(g.full?).to be_truthy
    end

    it 'returns false when there is only one player' do
      g = FactoryGirl.create(:game, :with_one_player)

      expect(g.full?).to be_falsey
    end
  end

  context 'check?' do
    it 'returns true when there is a check in the game from a horizontal attack' do
      g = FactoryGirl.create(:game, :with_two_players, :check_scenario1)
      # check if black (color: false) king is in check
      expect(g.check?(false)).to be true
    end

    it 'returns true when there is a check in the game from a vertical attack' do
      g = FactoryGirl.create(:game, :with_two_players, :check_scenario2)
      expect(g.check?(false)).to be true
    end

    it 'returns true when there is a check in the game from a diagonal attack' do
      g = FactoryGirl.create(:game, :with_two_players, :check_scenario3)
      expect(g.check?(false)).to be true
    end

    it 'returns true when there is a check in the game from a knight attack' do
      g = FactoryGirl.create(:game, :with_two_players, :check_scenario4)
      expect(g.check?(false)).to be true
    end

    it 'returns false when there are no checks in the game' do
      g = FactoryGirl.create(:game, :with_two_players)
      expect(g.check?(false)).to be false
    end
  end
  
  context 'checkmate?' do
    it 'returns false when checking piece can be captured' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
      g.pieces.create(type: 'Rook', x_coord: 1, y_coord: 7, color: true, first_move: false, captured: false)
      expect(g.checkmate?(false)).to be false
    end
    it 'returns false when king can move itself out of check' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
      g.pieces.create(type: 'Rook', x_coord: 2, y_coord: 7, color: true, first_move: false, captured: false)
      expect(g.checkmate?(false)).to be false
    end
    it 'returns false when checking piece can be blocked by another piece' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false)
      g.pieces.create(type: 'Rook', x_coord: 2, y_coord: 7, color: true, first_move: false)
      g.pieces.create(type: 'Queen', x_coord: 0, y_coord: 5, color: true, first_move: false)
      g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 6, color: false, first_move: false)
      # black bishop can move to (1,7) to block white rook from checking black king
      g.pieces.create(type: 'Bishop', x_coord: 3, y_coord: 5, color: false, first_move: false)
      expect(g.checkmate?(false)).to be false
    end
    it 'returns true when game state is in checkmate' do
      g = FactoryGirl.create(:game, :with_two_players)
      g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false)
      g.pieces.create(type: 'Rook', x_coord: 2, y_coord: 7, color: true, first_move: false)
      g.pieces.create(type: 'Queen', x_coord: 0, y_coord: 5, color: true, first_move: false) 
      expect(g.checkmate?(false)).to be true
    end
  end
  # context 'stalemate?' do
  #   it 'returns false when game is not in stalemate' do
  #   g = FactoryGirl.create(:game, :with_two_players)
  #   g.update(turn: 2)
  #   g.pieces.destroy_all
  #   bishop = g.pieces.create(type: 'Bishop', x_coord: 4, y_coord: 5, first_move: false, color: true, player_id: 1)
  #   g.pieces.create(type: 'King', x_coord: 4, y_coord: 7, first_move: false, color: true, player_id: 1)
  #   g.pieces.create(type: 'King', x_coord: 3, y_coord: 0, first_move: false, color: false, player_id: 2)
  #   bishop.move_to!(3, 6)
  #   g.update(turn: 3)
     
  #   expect(g.stalemate?).to be false
  #   end
    
  #   it 'returns true when in stalemate' do
  #   g = FactoryGirl.create(:game, :with_two_players)
  #   g.update(turn: 3)
  #   g.pieces.destroy_all
  #   g.pieces.create(type: 'Queen', x_coord: 6, y_coord: 2, first_move: false, color: true, player_id: 1)
  #   g.pieces.create(type: 'King', x_coord: 5, y_coord: 1, first_move: false, color: true, player_id: 1)
  #   g.pieces.create(type: 'King', x_coord: 7, y_coord: 0, first_move: false, color: false, player_id: 2)
     
  #   expect(g.stalemate?).to be true
  #   end
  # end
end
