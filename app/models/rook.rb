# frozen_string_literal: true
class Rook < Piece
  def image
    color ? '&#9814;' : '&#9820;'
  end
end
