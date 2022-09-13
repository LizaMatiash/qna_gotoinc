require 'rails_helper'

feature 'Create question', %q{
In order to get answer from a community
As an authenticated user
I'd like to be able to ask the question
} do

  given (:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    visit new_user_session_path
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Unautenticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
