# frozen_string_literal: true
class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:piece_id])
    @game = @piece.game
    @pieces = @game.pieces
  end

  private

  def piece_params
    @pieces_params = params.require(:pieces).permit
  end
end
