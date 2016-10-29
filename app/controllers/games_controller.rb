class GamesController < ApplicationController
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
end
end
