# frozen_string_literal: true
module Admin
  # frozen_string_literal: true
  class PiecesController < ApplicationController
    def update
      @piece = Piece.find(params[:id])
      @game = @piece.game

      @piece.attempt_move(params[:x_coord], params[:y_coord]) if right_player?

<<<<<<< HEAD
      render json: {
        update_url: game_path(@game)
      }
    end
=======
    render json: {
      update_url: game_path(@game)
    }

    update_firebase(
      update_url: game_path(@game),
      time_stamp: Time.now.to_i
    )
  end
>>>>>>> 483cd512978928bd332b545e31de786ffd26ff98

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
  end

  def update_firebase(data)
    firebase = Firebase::Client.new(Rails.application.config.base_uri)

    response = firebase.set("game#{@game.id}", data)
    response.success?
  end
end
