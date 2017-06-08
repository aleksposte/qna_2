require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign in
} do

  given(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    # Вынесли отдельно в given (будет создаваться с помощью фабрик)
    # User.create!(email: 'user@test.com', password: '1234567')

    sign_in(user)

    # Заменили на макрос sign_in(user)
    # visit new_user_session_path
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_on 'Log in'

    save_and_open_page
    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sing in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '1234567'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid Email or password'
    expect(current_path).to eq new_user_session_path
  end

end