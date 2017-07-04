require_relative 'acceptance_helper'

feature 'Best answer', %q{
  In order to be able to the best answer
  As an author of question
  I want to be able to select best answer
}do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create_list(:answer, 3, question: question) }

  scenario 'Non-authentificated user tries to select answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_selector('input[type=radio]')
    end
  end

  describe 'Authenticated author' do
    before do
      sign_in user
      visit question_path(quiestion)
    end

    scenario 'sees radio buttons' do
      within '.answers' do
        expect(page).to have_selector('input[type=radio]')
      end
    end

    scenario 'sets best answer', js: true do
      other_answer = create(:answer, question: question)
      visit question_path(question)
      within '.answers' do
        within "#answer_#{other_answer.id}" do
          choose 'best_answer'
        end
        expect(page).to have_content "You've set the best answer"
      end
    end

    scenario 'changes best answer', js: true do
      answer = question.answers.last
      other_answer = create(:answer, question: question, best: true)
      visit question_path(question)
      within '.answers' do
        within "#answer_#{answer.id}" do
          choose 'best_answer'
        end
        expect(page).to have_content "You've set the best answer"
      end
    end
  end
end
