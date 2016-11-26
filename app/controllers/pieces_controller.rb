class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    @piece.attempt_move(piece_params)

      render json: {
        update_url: game_path(@game)
      }
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(
      :x_position,
      :y_position,
      :type)
  end

end
