require 'rails_helper'

RSpec.describe "users#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/users/current", params: params
  end

  describe 'basic fetch' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    def current_user
      user2
    end

    it 'returns the current user' do
      expect(UserResource).to receive(:find).and_call_original
      make_request

      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('users')
      expect(d.id).to eq(user2.id)
    end
  end
end
