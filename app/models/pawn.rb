class Pawn < Piece; end
def self.get_image(color)
		if color == "white"
			return "white-pawn.png"
		elsif color == "black"
			return "black-pawn.png"
		end
	end
