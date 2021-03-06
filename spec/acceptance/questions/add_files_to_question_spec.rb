require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an quesition's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body ', with: 'Test body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Add file'
    all('input[type="file"]').last.set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'spec_helper_rb', href: '/uploads/attachment/file/2/spec_helper.rb'
  end
end