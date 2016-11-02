class GamesController < ApplicationController
 #before_action :authenticate_user!
 helper_method :game
  def index

  end

  def show
    @available_game = Game.new
  end

  def new
    @available_game = Game.new
  end

  def create
    @available_game = game_params[:user2_id]
    @available_game = Game.create(user2_id: new_user_id, user_id: current_user.id)
    @available_game.initialize_game_board!
    redirect_to game_path(@available_game)
  end

  def select    
  end

  def move
  end

  def update
    @available_game = Game.find(params[:id])

    if @available_game.update_attributes(params[:game])
      redirect_to games_path, notice: 'New game ready'
    else
      render 'fail to load new game'
    end
  end

    def destroy
      @available_game = Game.find(params[:id])
      @available_game.destroy
      redirect_to games_path, notice: 'Your game has been cancel'
    end

    private
  def game_params
    params.require(:game).permit(:user_id, :white_player_id, :black_player_id)
  end
end
