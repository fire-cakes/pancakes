class Piece < ActiveRecord::Base
	belongs_to :game
	belongs_to :player
  belongs_to :board

  def self.types
    %w(Pawn Rook Knight Bishop Queen King)
  end
  
  
  # x1 and y1 being the destination coordinates
  def is_obstructed?(x1, y1)
    current_game = Game.find(game_id)
    # starting coordinates
    x0 = self.x_coord
    y0 = self.y_coord
    #checks if destination is vertical, horizontal, or diagonal
    x_diff = x0 - x1
    y_diff = y0 - y1
    #array keeps list of coordinates of places between origin and destination
    places_between = [ [x1, y1] ]
    current_coordinates = [x0, y0]
    back_to_start = false
    #iterates through each places in between origin and destination
    until back_to_start
      if x1 > x0
        x1 = x1 - 1
      elsif x1 < x0
        x1 = x1 + 1
      end

      if y1 > y0
        y1 = y1 -  1
      elsif y1 < y0
        y1 = y1 + 1
      end

      if current_coordinates == [x1, y1]
        back_to_start = true
      else
        if x_diff == y_diff
          places_between << [x1, y1]
        elsif x_diff == 0
          places_between << [x0, y1]
        else
          places_between << [x1, y0]
        end
      end
    end
    
    # get coordinates for all pieces in current game
    pieces = current_game.pieces.to_a
    all_piece_coordinates = pieces.map { |p| [p.x_coord, p.y_coord] }
    # check if any pieces on board conflict with the coordinates between origin and destination piece position
    obstruction = false
    all_piece_coordinates.each do |piece_coordinates|
      is_current_piece = current_coordinates == piece_coordinates
      is_destination_piece = piece_coordinates == [x1, y1]  

      if x_diff == 0 && y_diff == 0
        obstruction = true
      end

      if places_between.include?(piece_coordinates) && !is_current_piece && !is_destination_piece       
        obstruction = true
      end

    end

    return obstruction

  end
end
