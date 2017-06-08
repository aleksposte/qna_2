require 'rails_helper'

feature 'Create answer', %q{
  In order to answer question
  As an authentificated user
  I want to be able to answer question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authentificatred user create valid answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'Answer', with: 'MyText'
    click_on 'Answer'
    save_and_open_page

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'MyText'
  end

  scenario 'Non-authentificated user tries to create answer' do
    visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
