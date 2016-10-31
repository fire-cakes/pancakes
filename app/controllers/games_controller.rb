class GamesController < ApplicationController
<<<<<<< HEAD
	# before_action :authenticate_player!
	def index
	end

	def show
	end

	def new
  		@available_game = Game.new
	end

	def create
		@available_game = Game.new(params[:game])
	end

	def edit
	end

	def update
		@available_game = Game.find(params[:id])

		if @available_game.update_attributes(params[:game])
			redirect_to root_path, :notice => "New game ready"
		else
			render "fail to load new game"
	end

	def destroy
		@available_game = Game.find(params[:id])
		@available_game.destroy
		redirect_to games_path, :notice => "Your game has been cancel"
	end
=======
  def index
  end

  def show
    @available_game = Game.find(params[:id])
  end

  def new
    @available_game = Game.new
  end

  def create
    @available_game = game_params[:user_id]
    @available_game = Game.create(user2_id: new_user_id, user_id: current_user.id )
    @available_game.initialize_game_board!
    redirct_to games_path(@available_game)
  end

  def edit
  end

  def update
    @available_game = Game.find(params[:id])

    if @available_game.update_attributes(params[:game])
      redirect_to games_path, notice: 'New game ready'
    else
      render 'fail to load new game'
  end

    def destroy
      @available_game = Game.find(params[:id])
      @available_game.destroy
      redirect_to games_path, notice: 'Your game has been cancel'
    end

    private
    def game_params
      params.require(:game).permit(:user_id, :user2_id)
>>>>>>> model
end
end
