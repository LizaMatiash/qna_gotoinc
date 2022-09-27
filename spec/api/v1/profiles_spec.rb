require 'rails_helper'

describe "Profiles API" do
  describe "GET /me" do
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get '/api/v1/profiles/me'
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

    it 'return 200 status' do
      # get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token }
      expect(response).to be_successful
    end

    it 'return all public fields' do
      %w[id email admin created_at updated_at].each do |attr|
        expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
      end
    end

    it 'does not return private fields' do
      %w[password encrypted_password].each do |attr|
        expect(response.body).to_not have_json_path(attr)
      end
    end
  end


  describe "GET /exept_me" do
    context "unauthorized" do
      it 'return 401 status if there is no access_token' do
        get '/api/v1/profiles/exept_me'
        expect(response.status).to eq 401
      end
      it 'return 401 status if access_token is invalid' do
        get '/api/v1/profiles/exept_me', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/exept_me', params: { format: :json, access_token: access_token.token } }

    it 'return 200 status' do
      # get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token }
      expect(response).to be_successful
    end

    it 'does not return private fields' do
      %w[password encrypted_password].each do |attr|
        expect(response.body).to_not have_json_path(attr)
      end
    end
  end
end
