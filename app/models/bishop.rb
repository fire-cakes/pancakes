class Bishop < Piece; end

def legal_move?(x, y)
    (x_coord - x).abs == (y_coord - y).abs
  end

  def obstructed_squares(x, y)
    diagonal_obstruction_array(x, y)
  end
end