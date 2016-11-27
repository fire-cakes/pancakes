# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#update action' do
    it 'successfully update the page' do
      expect(response).to have_http_status(:success)
    end
  end
end
