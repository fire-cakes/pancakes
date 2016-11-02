class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :white_player
  belongs_to :black_player
end
