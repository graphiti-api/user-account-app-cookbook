require 'rails_helper'

RSpec.describe AccountActivationsController, type: :request do
  let!(:user) { FactoryBot.create(:user, email_verified_at: nil) }
  subject(:make_request) do
    get "/account_activations/#{token}"
  end

  before do
    Timecop.freeze
  end

  context 'when the token matches a user' do
    let(:token) { Authentication::EmailActivation.new(user).mint_token }

    it 'updates the user verification field' do
      make_request

      expect(user.reload.email_verified_at).to eq Time.now
    end

    it 'redirects to a success page' do
      make_request

      expect(response).to redirect_to('/account_activations/success')
    end

    context 'when the user has already been verified' do
      before do
        user.update_attributes(email_verified_at: 2.years.ago)
      end

      it 'does not update the verified timestamp' do
        make_request

        expect(user.reload.email_verified_at).to eq 2.years.ago
      end
    end
  end

  context 'when the token does not match a user' do
    let(:token) { 'badtoken' }

    it 'redirects to an error page' do
      make_request

      expect(response).to redirect_to('/account_activations/error')
    end
  end
end