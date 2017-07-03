require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like of ot able to edit my answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }

  scenario 'Non-authentificated user try to edit question', js: true do
    visit question_path(question)
    expect(page).not_to have_content 'Edit'
  end

  describe 'Authentificated user' do

    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit', js: true do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his question', js: true do
      click_on 'Edit'
      within '.answers' do
        fiil_in 'Answer', with: 'edited answer'
      end
      click_on 'Save'
      expect(page).not_to have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).not_to have_selector 'textarea'
    end

    scenario "try to edit other user's question", js: true do
      other_user = create(:user)
      visit question_path(question)
      within '.answers' do
        expect(page).not_to have_content 'Edit'
       end
    end
  end
end