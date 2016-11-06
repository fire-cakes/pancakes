# frozen_string_literal: true
class Pawn < Piece
  def image
    color ? '&#9817;' : '&#9823;'
  end
end
