class PiecesController < ApplicationController
  def select
    @game = Game.find(params[:id])
    @pieces = Piece.find(params[:piece_id])
    @pieces = @game.pieces
    @piece_id = params[:piece_id]
    @x_coord = params[:x_coord]
    @y_coord = params[:y_coord]
  end

  def update
  	@pieces = Piece.find(params[:piece_id])
  	@game = @pieces.game
  	@pieces.update_attributes piece_params
  	redirect_to game_path
  end

  def valid_move?
    @pieces = Piece.find(params[:piece_id])
    if ! @piece.move_to!(params[:x_coord], params[:y_coord])
      flash[:notice] = "invalid move"
    else
      redirect_to game_path @pieces.game
    end
  end

  def move_to!
  	@pieces = Piece.find(params[:piece_id])
    if ! @pieces.move!(piece_params[:piece_id])
    	flash[:notice] = "invalid move"
    end
    redirect_to game_path @pieces.game
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(
      :piece_id,
      :x_coord,
      :y_coord,
      :type
    )
  end
end