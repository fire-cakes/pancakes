# frozen_string_literal: true
class Player < ActiveRecord::Base
  has_many :games
  has_many :pieces
end
