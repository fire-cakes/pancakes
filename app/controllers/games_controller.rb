class GamesController < ApplicationController
  # before_action :authenticate_player!
  def index
    # @games = Game.available
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def new
    @game = Game.new
  end

  def create
    @game = game_params[:user_id]
    @game = Game.create(user2_id: new_user_id, user_id: current_user.id)
    @game.initialize_game_board!
    redirct_to games_path(@available_game)
  end

  def edit
  end

  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      redirect_to games_path, notice: 'New game ready'
    else
      render 'fail to load new game'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, notice: 'Your game has been cancel'
  end

  private

  def game_params
    params.require(:game).permit(:user_id, :user2_id, :name, :white_player_id, :black_player_id)
  end
end
