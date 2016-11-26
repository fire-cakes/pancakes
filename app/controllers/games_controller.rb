# frozen_string_literal: true
class GamesController < ApplicationController
  before_action :authenticate_player!

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
    game = Game.find(params[:id])
    game.update_attributes game_params
    redirect_to game_path game
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
      :black_player_id
    )
  end
end
