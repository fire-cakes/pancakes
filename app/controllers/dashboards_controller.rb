# frozen_string_literal: true
class DashboardsController < ApplicationController
  before_action :authenticate_player!

  def show
    @user_games = user_games
  end

  def user_games
    return nil unless signed_in?
    @user_games = Game.where(params[:white_player_id]) + Game.where(params[:black_player_id]).order('updated_at').to_a.first(10)
  end

  private

  def dash_params
    params.require(:game).permit(
      :name,
      :white_player_id,
      :black_player_id
    )
  end
end
