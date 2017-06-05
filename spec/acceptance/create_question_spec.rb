require 'rails_helper'

feature 'Create question', %q{
  In order to get answers from community
  As an authenticated user
  I want to be able to create a question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    # User.create!(email: 'user@test.com', password: '1234567')

    sign_in(user)

    # Заменили на макрос sign_in(user)
    # visit new_user_session_path
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    # save_and_open_page
    click_on 'Create'

    expect(page).to have_content 'Your question was successfully created.'
    # expect(page).to have_content 'Вопрос создан.'
  end

  scenario 'Non-Authenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end