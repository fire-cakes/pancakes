# frozen_string_literal: true
class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    @piece.attempt_move(params[:x_coord], params[:y_coord]) if right_player?

    render json: {
      update_url: game_path(@game)
    }
  end

  private

  def piece_params
    @pieces_params = params.require(:piece).permit(
      :x_coord,
      :y_coord,
      :type
    )
  end

  # ensures current player is piece owner
  def right_player?
    current_player == Player.find(@piece.owner)
  end
end