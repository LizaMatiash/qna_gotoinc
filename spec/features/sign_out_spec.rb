require_relative 'feature_helper'

feature 'User can sign out', %q{
  In order to go out
  As an authenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Autorised user can sign out' do
    visit new_user_session_path
    sign_in(user)
    visit questions_path

    click_on 'Log Out'

    expect(page).to have_content 'Signed out successfully'

  end

end
