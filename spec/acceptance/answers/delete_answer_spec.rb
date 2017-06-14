require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to delete my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  scenario 'Authenticated user deletes his answer' do
    sign_in(answer.user)
    visit question_path(answer.question)
    click_on 'Delete'
    # save_and_open_page
    expect(page).to have_content 'Your answer successfully deleted'
    expect(page).not_to have_content answer.body
  end

  scenario 'Authenticated user deletes others answer' do
    other_user = create(:user)
    sign_in(other_user)
    visit question_path(answer.question)
    expect(page).not_to have_link 'Delete'
  end

  scenario 'Non-Authenticated user tries to delete answer' do
    visit question_path(answer.question)
    expect(page).not_to have_link 'Delete'
  end
end
