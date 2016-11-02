class Queen < Piece; end
def self.get_image(color)
		if color == "white"
			return "white-queen.png"
		elsif color == "black"
			return "black-queen.png"
		end
	end
