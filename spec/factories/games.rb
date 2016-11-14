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
    
    trait :check_scenario do
      after :create do |g|
        g.pieces.destroy_all
        # white rook checks black king
        g.pieces.create(type: 'King', x_coord: 0, y_coord: 7, color: false, first_move: false, captured: false)
        g.pieces.create(type: 'Rook', x_coord: 2, y_coord: 7, color: true, first_move: false, captured: false)
      end
    end
  end
end
