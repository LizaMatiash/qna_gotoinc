require_relative 'feature_helper'

feature 'Add files to question', %(
  In order to illustrate my problem
  As an aurhor of question
  I want to add file
) do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Authenticated user creates question', js: true do

    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Test body'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"

    click_on 'Create'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end


end
