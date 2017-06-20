require_relative 'acceptance_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to delete my question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user delete his question' do
    sign_in(user)
    visit questions_path
    click_on 'Delete'
    expect(page).to have_content 'Your question was successfully deleted.'
    expect(page).not_to have_content question.title
    expect(page).not_to have_content question.body
  end

  scenario 'Authenticated user tries to delete others question' do
    other_user = create(:user)
    sign_in(other_user)
    visit questions_path
    expect(page).not_to have_link 'Delete'
  end

  scenario 'Non-Authenticated user tries to delete question' do
    visit questions_path
    expect(page).not_to have_link 'Delete'
  end
end