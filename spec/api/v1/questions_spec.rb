require 'rails_helper'

describe "Questions API" do
  describe 'GET /api/v1/index' do
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get '/api/v1/questions'
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question, user: me) }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return list of questions' do
        expect(response.body).to have_json_size(2)
        # expect(json['questions'].size).to eq 2
      end

      it 'return all public fields' do
        %w[title body created_at updated_at].each do |attr|
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      it 'contains short title' do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path('0/short_title')
      end

      context 'answers' do
        it 'includes answers area' do
          expect(response.body).to have_json_size(1).at_path('0/answers')
        end

        it 'return all public fields' do
          %w[id body created_at updated_at].each do |attr|
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end
  end

  describe 'GET /questions/question_id' do
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get '/api/v1/questions'
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:question) { create(:question, :with_comments) }

      before { get "/api/v1/questions/#{question.id}", params: { format: :json, access_token: access_token.token } }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return all public fields' do
        %w[title body created_at updated_at comments].each do |attr|
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end
    end
  end

  describe 'POST /questions/create' do
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get '/api/v1/questions'
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      it 'return 200 status' do

        post '/api/v1/questions', xhr: true, params: { question: {body: 'question body', title: 'title of question'}, access_token: access_token.token}
        expect(response).to be_successful
      end

      it 'save the valid answer in the database' do
        expect do
          post '/api/v1/questions', params: { question: {body: 'question body', title: 'title of question'}, access_token: access_token.token }
        end.to change(Question, :count).by(1)
      end

    end
  end
end
