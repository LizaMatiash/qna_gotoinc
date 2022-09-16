require_relative 'feature_helper'

feature 'Add files to answer', %(
  In order to illustrate my answer
  As an aurhor of answer
  I want to add file
) do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  background do
    sign_in(user)
    visit questions_path
    click_on question.body
  end

  scenario 'Authenticated user creates answer', js: true do
    fill_in 'Body', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Add answer'

    within('.answers') do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end


end
