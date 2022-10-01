require 'rails_helper'

describe "Profiles API" do
  describe "GET /me" do
    let(:api_path) { '/api/v1/profiles/me' }
    let(:method) { 'get' }

    it_behaves_like 'API Authorizable'
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }
    let(:list) { %w[id email admin created_at updated_at] }
    let(:model) { "me" }
    let(:list_path) {""}

    before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

    it_behaves_like 'API Success'

    it_behaves_like 'API return Success'

    it_behaves_like 'API dont return private'
  end


  describe "GET /exept_me" do
    let(:api_path) { '/api/v1/profiles/exept_me' }
    let(:method) { 'get' }

    it_behaves_like 'API Authorizable'
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/exept_me', params: { format: :json, access_token: access_token.token } }

    it_behaves_like 'API Success'

    it_behaves_like 'API dont return private'
  end
end
