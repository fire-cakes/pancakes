# frozen_string_literal: true
  class GamesController < ApplicationController
    add_flash_types :success, :warning
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
      @game = Game.find(params[:id])
      @game.update_attributes game_params
        unless @game.valid_move?
          format.html { redirect_to game_path(@game), warning: 'Illegal move' }
        end

        if @game.check
          format.html { redirect_to game_path(@game), success: 'In check' }
        end
    end

    def destroy
      @game = Game.find(params[:id])
      if @game.destroy
        format.html { redirect_to game_path(@game), notice: 'Your has been cancel' }
      end
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