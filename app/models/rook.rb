class Rook < Piece; end

def self.get_image(color)
		if color == "white"
			return "white-rook.png"
		elsif color == "black"
			return "black-rook.png"
		end
		
	end

	
