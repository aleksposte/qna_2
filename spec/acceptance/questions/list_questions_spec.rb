require 'rails_helper'

feature 'User can view list of quiestion', %q{
 As an user
 I want view a list of question
 } do

  given(:user) { create(:user) }

  scenario 'Authenticated user can view a list of question' do
    sign_in(user)

    questions = create_list(:question, 3)
    visit questions_path
    questions.each do |question|

      expect(page).to have_content(question.title, question.body )
    end
  end

  scenario 'Non-authenticated user can view a list of question' do
    sign_in(user)

    questions = create_list(:question, 3)
    visit questions_path
    # save_and_open_page
    questions.each do |question|

      expect(page).to have_content(question.title, question.body )
    end
  end

end
