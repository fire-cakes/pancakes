# frozen_string_literal: true
FactoryGirl.define do
  factory :game do
    id 1
    status 1

    trait :with_one_player do
      white_player_id 1
      black_player_id nil
    end

    trait :with_two_players do
      white_player_id 1
      black_player_id 2
    end

    # Test horizontal check
    trait :check_scenario1 do
      after :create do |g|
        g.pieces.destroy_all
        # white rook checks black king
        g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 2, y_coord: 7, color: true, first_move: false, captured: false)
      end
    end

    # Test vertical check
    trait :check_scenario2 do
      after :create do |g|
        g.pieces.destroy_all
        # white rook checks black king
        g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 0, y_coord: 4, color: true, first_move: false, captured: false)
      end
    end

    # Test diagonal check
    trait :check_scenario3 do
      after :create do |g|
        g.pieces.destroy_all
        # white rook checks black king
        g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Bishop', x_coord: 2, y_coord: 5, color: true, first_move: false, captured: false)
      end
    end

    # Test knight check
    trait :check_scenario4 do
      after :create do |g|
        g.pieces.destroy_all
        # white rook checks black king
        g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Knight', x_coord: 2, y_coord: 6, color: true, first_move: false, captured: false)
      end
    end

    trait :obstruction do
      after :create do |g|
        g.pieces.destroy_all
        # test case board from: https://gist.github.com/kenmazaika/92b81db9e977578c8d94
        g.pieces.create(type: 'Pawn', x_coord: 0, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 5, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 6, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 7, y_coord: 1, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 0, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Knight', x_coord: 1, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'King', x_coord: 3, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Bishop', x_coord: 5, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Knight', x_coord: 6, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 7, y_coord: 0, color: false, first_move: true, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 0, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 7, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'King', x_coord: 3, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Queen', x_coord: 4, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Bishop', x_coord: 5, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Knight', x_coord: 6, y_coord: 7, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 2, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 3, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 4, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 5, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 6, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 7, y_coord: 6, color: true, first_move: true, captured: false)
        g.pieces.create(type: 'Bishop', x_coord: 0, y_coord: 5, color: true, first_move: false, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 1, y_coord: 5, color: true, first_move: false, captured: false)
        g.pieces.create(type: 'Bishop', x_coord: 7, y_coord: 5, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Pawn', x_coord: 2, y_coord: 3, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Knight', x_coord: 3, y_coord: 3, color: true, first_move: false, captured: false)
      end
    end
  end
end
