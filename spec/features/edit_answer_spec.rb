require_relative 'feature_helper'

feature 'Answer edit', %q{
In case to fix mistake
As answer author
I want to change it
}do
given!(:user) { create(:user) }
given!(:user1) { create(:user) }
given!(:question) { create(:question, user: user) }
given!(:answer) { create(:answer, question: question, user: user) }

scenario 'Unauthenticated user try to edit answer' do
  visit questions_path
  click_on question.body

  expect(page).to_not have_link 'Edit'
end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit questions_path
      click_on question.body
    end

    scenario 'Author see link EDIT' do
      within('.answers') do
        expect(page).to have_link('Edit')
      end
    end

    scenario 'Author edit his question', js: true do
      click_on 'Edit'
      within('.answers') do
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'

        # visit questions_path
        # click_on question.body

        expect(page).to_not have_content answer.body
        expect(page).to have_content('Edited answer')
        expect(page).to_not have_selector 'textarea'
      end


    end
  end

  scenario 'User tries to edit not his answer' do
    sign_in(user1)
    visit questions_path
    click_on question.body

    expect(page).to_not have_link 'Edit'
  end
end
