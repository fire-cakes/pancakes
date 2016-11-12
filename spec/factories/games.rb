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
  end
end
