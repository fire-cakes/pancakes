# frozen_string_literal: true
FactoryGirl.define do
  factory :player do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
