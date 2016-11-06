# frozen_string_literal: true
feature 'Sign out', :omniauth do
  scenario 'user signs out successfully' do
    signin
    click_link 'Sign out'
    expect(page).to have_cotent 'Signed out'
  end
end
