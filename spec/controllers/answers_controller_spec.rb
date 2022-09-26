require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question2) {create(:question, user: user)}
  let!(:answer) {create(:answer, question: question2, user: user)}

  before { login(user) }
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the answer in the database' do
        expect{ post :create, params: { answer: attributes_for(:answer), question_id: question2 }, format: :js }.to change(question2.answers, :count).by(1)

      end

      it 'redirect to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question2 }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer in the database' do
        expect{ post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question2 }, format: :js }.to_not change(Answer, :count)
      end
      it 'redirect to show view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question2 }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'POST #update' do
    context 'with valid attributes' do
     it 'change answer attrubutes' do
       patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
       answer.reload

       expect(answer.body).to eq 'body_of_answer7'
     end

     it 'renders update view' do
       patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
       expect(response).to render_template :update
     end

   end
  end

end
