require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like of ot able to edit my answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }

  # Non-authentificated user
  scenario 'Non-authentificated user try to edit question' do
    visit question_path(question)
    expect(page).not_to have_content 'Edit'
  end

  describe 'Authentificated user' do

    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Sees link to Edit' do
      within '.answers' do
        expect(page).to have_content 'Edit'
      end
    end

    scenario 'Try to edit his question', js: true do
      click_on 'Edit'
      within '.answers' do
        fiil_in 'Answer', with: 'edited answer'
      end
      click_on 'Save'
      expect(page).not_to have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).not_to have_selector 'textarea'
    end

    scenario "Try to edit other user's question" do

    end
  end
end