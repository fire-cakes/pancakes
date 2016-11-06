# frozen_string_literal: true
class Bishop < Piece
  def image
    color ? '&#9815;' : '&#9821;'
  end
end
