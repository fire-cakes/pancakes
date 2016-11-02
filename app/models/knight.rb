class Knight < Piece; end
def self.get_image(color)
		if color == "white"
			return "white-knight.png"
		elsif color == "black"
			return "black-knight.png"
		end
	end
