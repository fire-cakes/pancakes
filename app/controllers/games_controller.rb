class GamesController < ApplicationController
	def index
		@available_games = Game.all
	end

	def show
	end

	def new
  		@available_games = Game.new
	end

	def create
		@available_games = Game.new(params[:game])
	end

	def edit
	end

	def update
		@available_games = Game.find(params[:id])

		if @available_games.update_attributes(params[:game])
			redirect_to root_path, :notice => "New game ready"
		else
			render "fail to load new game"
	end

	def destroy
		@available_games = Game.find(params[:id])
		@available_games.destroy
		redirect_to games_path, :notice => "Your game has been cancel"
	end
end
end
