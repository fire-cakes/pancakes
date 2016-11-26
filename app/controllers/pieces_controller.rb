# frozen_string_literal: true
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
    @pieces_params = params.require(:pieces).permit(
      :x_coord,
      :y_coord,
      :type
    )
  end
end
