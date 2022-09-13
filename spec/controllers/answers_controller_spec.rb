require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) {create(:question, user: user)}
  let!(:answer) {create(:answer, question: question, user: user)}

  before { login(user) }
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the answer in the database' do
        expect{ post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)

      end

      it 'redirect to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer in the database' do
        expect{ post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(Answer, :count)
      end
      it 'redirect to show view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to redirect_to question
      end
    end
  end

end