require 'rails_helper'

describe "Answers API" do
  describe 'GET /api/v1/questions/question_id/answers' do
    let(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:method) { 'get' }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:answers) { create_list(:answer, 3, question: question) }
      let(:answer) { answers.first }
      let(:list) { %w[body created_at updated_at] }
      let(:list_path) { "0/" }
      let(:model) { "answer" }

      before { get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token } }

      it_behaves_like 'API Success'

      it 'return list of answers' do
        expect(response.body).to have_json_size(3)
      end

      it_behaves_like 'API return Success'
    end
  end

  describe 'GET /questions/question_id/answers/aswer_id' do
    let(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:method) { 'get' }
    let(:list) { %w[body created_at updated_at comments] }
    let(:list_path) { "" }
    let(:model) { "answer" }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:answer) { create(:answer, :with_comments, question: question) }

      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", params: { format: :json, access_token: access_token.token } }

      it_behaves_like 'API Success'
      it_behaves_like 'API return Success'
    end
  end

  describe 'POST /questions/create' do
    let(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:method) { 'post' }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:valid_params) { {body: 'answer body'} }

      before { post "/api/v1/questions/#{question.id}/answers", xhr: true, params: { answer: valid_params, access_token: access_token.token} }

      it_behaves_like 'API Success'

      it 'save the valid answer in the database' do
        expect do
          post "/api/v1/questions/#{question.id}/answers", params: {answer: valid_params, access_token: access_token.token }
        end.to change(Answer, :count).by(1)
      end
    end
  end
end
