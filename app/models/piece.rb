class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :board

  def self.types
    %w(Pawn Rook Knight Bishop Queen King)
  end
end
