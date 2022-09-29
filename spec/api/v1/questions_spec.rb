require 'rails_helper'

describe "Questions API" do
  describe 'GET /api/v1/index' do
    let(:api_path) { '/api/v1/questions' }
    let(:method) { 'get' }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question, user: me) }
      let(:list) { %w[title body created_at updated_at] }
      let(:list_path) {"0/"}
      let(:model) { "question" }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it_behaves_like 'API Success'

      it 'return list of questions' do
        expect(response.body).to have_json_size(2)
      end

      it_behaves_like 'API return Success'

      it 'contains short title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path('0/short_title')
      end

      context 'answers' do
        it 'includes answers area' do
          expect(response.body).to have_json_size(1).at_path('0/answers')
        end

        let(:list) { %w[id body created_at updated_at] }
        let(:list_path) {"0/answers/0/"}
        let(:model) { "answer" }

        it_behaves_like 'API return Success'
      end
    end
  end

  describe 'GET /questions/question_id' do
    let(:question) { create(:question, :with_comments) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:method) { 'get' }
    it_behaves_like 'API Authorizable'
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:list) { %w[title body created_at updated_at] }
      let(:list_path) {""}
      let(:model) { "question" }


      before { get "/api/v1/questions/#{question.id}", params: { format: :json, access_token: access_token.token } }

      it_behaves_like 'API Success'

      it_behaves_like 'API return Success'
    end
  end

  describe 'POST /questions/create' do
    let(:api_path) { '/api/v1/questions' }
    let(:method) { 'post' }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:valid_params) { { title: 'title of question', body: 'question body' } }

      before { post '/api/v1/questions', xhr: true, params: { question: valid_params , access_token: access_token.token} }

      it_behaves_like 'API Success'

      it 'save the valid answer in the database' do
        expect do
          post '/api/v1/questions', params: { question: valid_params, access_token: access_token.token }
        end.to change(Question, :count).by(1)
      end

    end
  end
end
