require 'rails_helper'

feature 'User can destroy question', %q{
If it is users quetion he can
Destroy it
} do
  given(:user) { create(:user) }
  given(:user1) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Autorised User can delete question' do
    visit new_user_session_path
    sign_in(user)
    visit questions_path

    click_on question.body

    within('.question') do
      expect(page).to have_link('Destroy')
      click_on 'Destroy'
    end

    expect(page).to have_content 'Your question successfully destroyed.'
  end

  scenario 'User can`t delete not his question' do
    visit new_user_session_path
    sign_in(user1)
    visit questions_path

    click_on question.body

    within('.question') do
      expect(page).to_not have_link('Destroy')
    end
  end


end
