# frozen_string_literal: true
class DashboardsController < ApplicationController
  before_action :authenticate_player!

  def show
    @user_games = user_games
    @available_games = available_games
  end

  def user_games
    if signed_in?
      @user_games = Game.where(black_player_id: current_player.id) + Game.where(white_player_id: current_player.id).order('updated_at').to_a.first(10)
    end
  end

  def available_games
    if signed_in?
      @available_games = Game.where(black_player_id: nil).where.not(white_player_id: current_player.id).to_a.first(10)
    end
  end
end
