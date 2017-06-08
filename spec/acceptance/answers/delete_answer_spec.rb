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
    answer_body = answer.body
    # save_and_open_page
    click_on 'Delete'

    expect(page).not_to have_content answer_body
  end

  scenario 'Authenticated user deletes others answer' do
    user_1 = create(:user)
    sign_in(user_1)

    visit question_path(answer.question)

    expect(page).not_to have_link 'Delete'
  end

  scenario 'Non-Authenticated user tries to delete answer' do
    visit question_path(answer.question)

    expect(page).not_to have_link 'Delete'
  end

end
