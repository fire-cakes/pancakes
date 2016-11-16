# frozen_string_literal: true
class PiecesController < ApplicationController
  def select
    @piece = Piece.find(params[:piece_id])
    @game = @piece.game
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find(params[:piece_id])
    @game = @piece.game
    @piece.update_attributes piece_params
    redirect_to game_path
  end

  def valid_move?
    @piece = Piece.find(params[:piece_id])
    if !@piece.move_to!(params[:x_coord], params[:y_coord])
      flash[:notice] = 'invalid move'
    else
      redirect_to game_path
    end
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(
      :x_coord,
      :y_coord
    )
  end
end
