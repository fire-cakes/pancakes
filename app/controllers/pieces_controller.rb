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

  def edit
  end

  def valid_move?
    @piece = Piece.find(params[:piece_id])
    if !@piece.move_to!(params[:x_coord], params[:y_coord])
      flash[:notice] = 'invalid move'
    else
      redirect_to game_path
    end
  end

  def move_to!
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
