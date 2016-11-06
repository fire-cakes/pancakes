# frozen_string_literal: true
class Knight < Piece
  def image
    color ? '&#9816;' : '&#9822;'
  end
end
