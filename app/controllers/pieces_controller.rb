# frozen_string_literal: true
class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    @piece.attempt_move(params[:x_coord], params[:y_coord]) if right_player?

    render json: {
      update_url: game_path(@game)
    }

    update_firebase(
      update_url: game_path(@game),
      time_stamp: Time.now.to_i
    )
  end

  private

  def piece_params
    @pieces_params = params.require(:piece).permit(
      :x_coord,
      :y_coord,
      :type
    )
  end

  # ensures current player is piece owner
  def right_player?
    current_player == Player.find(@piece.owner)
  end

  def update_firebase(data)
    firebase = Firebase::Client.new(Rails.application.config.base_uri)

    response = firebase.set("game#{@game.id}", data)
    response.success?
  end
end
