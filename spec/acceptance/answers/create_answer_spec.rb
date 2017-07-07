require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to answer question
  As an authentificated user
  I want to be able to answer question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authentificatred user create answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Answer', with: 'MyText'
    click_on 'Answer'
    # save_and_open_page
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'MyText'
  end

  scenario 'Authentificated user creates invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Answer'
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authentificated user tries to create answer', js: true do
    visit question_path(question)
    expect(page).not_to have_content 'Answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
