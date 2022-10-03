require_relative 'feature_helper'

RSpec.feature "Subscription", type: :feature do
  describe 'authenticated user' do
    let(:user) { create(:user) }
    let!(:user1) { create(:user) }
    let!(:question) { create(:question, user: user) }

    before do
      sign_in(user1)
      visit questions_path
      click_on question.body
    end

    scenario 'subscribes to question' do
      click_on 'Subscribe'
      expect(page).to have_content 'Subscribed successfully!'
    end

    scenario 'unsubscribes from question' do
      click_on 'Subscribe'
      click_on 'Unsubscribe'
      expect(page).to have_content 'Unsubscribed successfully!'
    end

  end
end
