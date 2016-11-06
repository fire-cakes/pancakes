# frozen_string_literal: true
class Queen < Piece
  def image
    color ? '&#9813;' : '&#9819;'
  end
end
