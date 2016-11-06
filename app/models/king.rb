class King < Piece
	  def image
	    color ? '&#9812;' : '&#9818;'
	  end

	  def obstructed?(new_x, new_y)
	    if correct_moves.include? [new_x, new_y]
	      true
	    else
	      false
	  end


	  def valid_move?(new_x, new_y)
	    unless !super
	    	return false 
	    end
	    y_distance = (new_y - @y_coord).abs
	    x_distance = (new_x - @x_coord).abs
	    return false if y_distance > 1 || x_distance > 1
	    true
	  end

	  def move_to
	    piece = Piece.find(id)
	    x0 = piece.x_coord
	    y0 = piece.y_coord

	    # available moves for king
	    up = [x0, y0 + 1]
	    down = [x0, y0 - 1]
	    right = [x0 + 1, y0]
	    left = [x0 - 1, y0]

	    valid_moves = []

	    # valid move only if
	    move_up = y0 != 7
	    move_down = y0.nonzero?
	    move_left = x0.nonzero?
	    move_right = x0 != 7

	    valid_moves.push(up) if move_up
	    valid_moves.push(down) if move_down
	    valid_moves.push(left) if move_left
	    valid_moves.push(right) if move_right

	    valid_moves
	end
end