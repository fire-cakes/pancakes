# frozen_string_literal: true
FactoryGirl.define do
  factory :piece do
    id 1
    type ''
    color false
    x_coord 1
    y_coord 1
    captured false
    player_id 1
    game_id 1
  end
end
