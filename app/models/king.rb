# frozen_string_literal: true
class King < Piece
  def image
    color ? '&#9812;' : '&#9818;'
  end
end
