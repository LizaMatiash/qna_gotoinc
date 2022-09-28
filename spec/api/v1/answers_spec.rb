require 'rails_helper'

describe "Answers API" do
  describe 'GET /api/v1/questions/question_id/answers' do
    let(:question) { create(:question) }
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers"
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:answers) { create_list(:answer, 3, question: question) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token } }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return list of answers' do
        expect(response.body).to have_json_size(3)
      end

      it 'return all public fields' do
        %w[body created_at updated_at].each do |attr|
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end
  end

  describe 'GET /questions/question_id/answers/aswer_id' do
    let(:question) { create(:question) }
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers"
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end
    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:answer) { create(:answer, :with_comments, question: question) }

      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", params: { format: :json, access_token: access_token.token } }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return all public fields' do
        %w[body created_at updated_at comments].each do |attr|
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end
    end
  end

  describe 'POST /questions/create' do
    let(:question) { create(:question) }
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers"
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      it 'return 200 status' do

        post "/api/v1/questions/#{question.id}/answers", xhr: true, params: { answer: {body: 'answer body'}, access_token: access_token.token}
        expect(response).to be_successful
      end

      it 'save the valid answer in the database' do
        expect do
          post "/api/v1/questions/#{question.id}/answers", params: {answer: {body: 'answer body'}, access_token: access_token.token }
        end.to change(Answer, :count).by(1)
      end
    end
  end
end
