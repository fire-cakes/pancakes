# frozen_string_literal: true
class PiecesController < ApplicationController
  def valid_move?
    @piece = Piece.find(params[:piece_id])
    if !@piece.move_to!(params[:x_coord], params[:y_coord])
      flash[:notice] = 'invalid move'
    else
      redirect_to game_path(@piece.game)
    end
  end

  def move_to!(new_x, new_y)
      if return_piece(piece_params).player_id != current_player
        capture_piece(piece_params)
      @piece.update_attributes piece_params
      redirect_to game_path
  end

  def update
    @piece = Piece.find(params[:piece_id])
    @game = @piece.game
    @pieces = @game.pieces
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
