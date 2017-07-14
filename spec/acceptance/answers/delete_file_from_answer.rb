require 'acceptance_helper'

feature 'Delete files from answer attachment', %q{
  In order to delete file from answer
  As an authenticated user
  I want to be able to delete file from my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'Authenticated user deletes file from his answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      within "li#attachment_#{attachment.id}" do
        click_on 'Delete file'
      end
      expect(page).to_not have_content attachment.file.identifier
    end
  end

  scenario "Authenticated user tries to delete file from other users" do
    other_user = create(:user)
    sign_in(other_user)
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_link 'Delete file'
    end
  end

  scenario 'Non-Authenticated user tries to delete file' do
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_link 'Delete file'
    end
  end
end
