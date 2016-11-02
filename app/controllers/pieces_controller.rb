class PiecesController < ApplicationController

	def update
		@piece = Piece.find(params[:id])
		@vailable_game = @piece.available_game
	    if @piece.update_attributes(params[:piece])
	      redirect_to(@available_game)
	    else
	      render " "
	    end
	end

	private

	  def piece_params
	    params.require(:piece).permit(:x_coord, :y_coord, :types)
	  end
end
