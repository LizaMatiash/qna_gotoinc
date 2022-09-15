require_relative 'feature_helper'

feature 'User can see list of questions', %q{
In order to get answer from a community
As an authenticated user
I'd like to be able to ask the question
} do

  given!(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'User can see questions' do
    visit new_user_session_path
    sign_in(user)
    visit questions_path

    questions.each do |question|
      expect(page).to have_content(question.title)
      expect(page).to have_content(question.body)
    end
  end
end
