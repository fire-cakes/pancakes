# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index action' do
    it 'successfully shows the page' do
      player = FactoryGirl.create(:player)
      sign_in player

      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
