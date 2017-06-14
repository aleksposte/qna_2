require 'rails_helper'

feature 'User sign out', %q{
  To leave as a user
  I want to be able to get out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to logout' do
    sign_in(user)
    visit root_path
    click_on 'Sign out'
    expect(page).to have_content('Signed out successfully')
    expect(current_path).to eq root_path
  end

end
