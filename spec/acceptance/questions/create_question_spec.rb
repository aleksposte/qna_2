require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answers from community
  As an authenticated user
  I want to be able to create a question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'MyString'
    fill_in 'Body', with: 'MyText'
    # save_and_open_page
    click_on 'Create'
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'Your question was successfully created.'
  end

  scenario 'Authentificated user creates invalid question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    click_on 'Create'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-Authenticated user tries to create question' do
    visit questions_path
    # save_and_open_page
    expect(page).not_to have_content 'Create'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end