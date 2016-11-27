# frozen_string_literal: true
class GamesController < ApplicationController
  before_action :authenticate_player!
  helper_method :game

  def index
    @avaliable_games = Game.available
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def edit
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @game = Game.find(params[:id])
    if @game.valid?
    end
    @piece = @game.pieces.find(params[:piece_id])
    @piece.move_to!(params[:x_coord], params[:y_coord])
    notice = if @piece.x_coord == params[:x_coord] && @piece.y_coord == params[:y_coord]
               'piece has been move'
             else
               'invalid move'
             end
    redirect_to game_path @game, notice: notice
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, notice: 'Your game has been cancel'
  end

  private

  def game_params
    params.require(:game).permit(
      :name,
      :white_player_id,
      :black_player_id,
      :x_coord,
      :y_coord,
      :piece_id,
      :player_color
    )
  end
end
