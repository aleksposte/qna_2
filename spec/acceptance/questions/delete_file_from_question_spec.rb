require 'acceptance_helper'

feature 'Delete files from question', %q{
  In order to delete file from question
  As an quesition's author
  I want to be able to delete file from my question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'Authenticated user deletes file to his question', js: true do
    sign_in(user)
    visit question_path(question)
    within 'question_files' do
      click_on 'Delete file'
      expect(page).to_not have_content attachment.file.identifier
    end
  end

  scenario "Authenticated user tries to delete file from other users" do
    other_user = create(:user)
    sign_in(other_user)
    visit question_path(question)
    within '.question_files' do
      expect(page).not_to have_link 'Delete file'
    end
  end

  scenario 'Non-Authenticated user tries to delete file' do
    visit question_path(question)
    within '.question_files' do
      expect(page).not_to have_link 'Delete file'
    end
  end
end