class King < Piece; end
def self.get_image(color)
		if color == "white"
			return "white-king.png"
		elsif color == "black"
			return "black-king.png"
		end
	end
