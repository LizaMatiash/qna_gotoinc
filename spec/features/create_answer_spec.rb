require 'rails_helper'

feature 'User can add answer for question', %q{
In order to get answer for a community
As an authenticated user
I'd like to be able to add answer for question
} do

  given(:user1) { create(:user) }
  given!(:question) { create(:question, user: user1) }
   # given!(:question) { create(:question) }
   describe 'Authenticated user' do
     given(:user) { create(:user) }
     background do
       visit new_user_session_path
       sign_in(user)
       visit questions_path
       click_on question.body
     end

     scenario 'Autorised user can put answers' do
       fill_in 'Body', with: 'Test answer'
       click_on 'Add answer'
       expect(page).to have_content 'Test answer'
     end

     scenario 'Can`t add blank answers' do
      click_on 'Add answer'
      expect(page).to have_content "Body can't be blank"
    end
   end

   describe 'Unauthenticated user' do
    background do
      visit questions_path
      click_on question.body
    end

    scenario 'add answer for the question' do
      fill_in 'Body', with: 'My answer'
      click_on 'Add answer'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end


end
