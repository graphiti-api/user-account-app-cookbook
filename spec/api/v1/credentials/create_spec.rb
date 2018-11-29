require 'rails_helper'

RSpec.describe "credentials#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/credentials", payload
  end

  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'credentials',
          attributes: {
            email: user.email,
            password: 'pa$$w0rd',
          }
        }
      }
    end

    let!(:user) { FactoryBot.create(:user, password: 'pa$$w0rd') }

    before do
      allow_any_instance_of(Credential).to receive(:mint_jwt).and_return('thejwt')
    end

    it 'works' do
      expect(CredentialResource).to receive(:build).and_call_original

      make_request

      expect(response.status).to eq(201)
      expect(d.attributes['json_web_token']).to eq 'thejwt'
    end

    it 'allows user to be sideloaded' do
      payload[:include] = 'user'

      make_request

      expect(jsonapi_included('users').first.attributes['id']).to eq user.id.to_s
    end
  end
end
