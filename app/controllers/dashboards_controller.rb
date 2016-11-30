# frozen_string_literal: true
class DashboardsController < ApplicationController
  before_action :authenticate_player!

  def show
    @feature_games = feature_games
    @available_games = available_games
  end

  def feature_games
    if signed_in?
      @feature_games = Game.where('white_player_id = ? or black_player_id = ?', current_player.id, current_player.id).order('updated_at').to_a.first(10)
    end
  end

  def available_games
    if signed_in?
      @available_games = Game.where(black_player_id: nil).where.not(white_player_id: current_player.id).to_a.first(10)
    end
  end
end
