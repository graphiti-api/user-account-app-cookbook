require 'rails_helper'

RSpec.describe 'Authorization and authentication', type: :controller do
  controller(ApplicationController) do
    skip_before_action :authenticate_user!,
      only: [:unauthenticated_action, :unauthenticated_with_user_action]

    def unauthenticated_action
      head :ok
    end

    def unauthenticated_with_user_action
      if current_user
        render plain: "Welcome #{current_user.name}"
      else
        render plain: 'Welcome Guest'
      end
    end

    def authenticated_action
      head :ok
    end

    def unauthorized_action
      unauthorized!
    end
  end

  before do
    action = target_action
    routes.draw { get 'index' => "anonymous##{action}"}
  end

  subject(:make_request) do
    if auth_jwt
      request.set_header 'HTTP_AUTHORIZATION', "Bearer #{auth_jwt}"
    end

    get target_action
  end

  context 'when not logged in' do
    let(:auth_jwt) { nil }

    describe 'unauthenticated action' do
      let(:target_action) { 'unauthenticated_action' }

      it 'returns a success' do
        make_request

        expect(response).to be_successful
      end
    end

    describe 'unauthenticated action which references current user' do
      let(:target_action) { 'unauthenticated_with_user_action' }

      it 'returns an anonymous response' do
        make_request

        expect(response.body).to eq 'Welcome Guest'
      end
    end

    describe 'authenticated action' do
      let(:target_action) { 'authenticated_action' }

      it 'returns an unauthenticated response' do
        make_request

        expect(response.status).to eq 401
        expect(response.body).to match(/No Authorization token provided/)
      end
    end

    describe 'unauthorized action' do
      let(:target_action) { 'unauthorized_action' }

      it 'returns an unauthenticated response' do
        make_request

        expect(response.status).to eq 401
      end
    end
  end

  context 'when valid user token is passed in the header' do
    let(:current_user) { FactoryBot.create(:user) }
    let(:auth_jwt) { Credential.new(user: current_user).mint_jwt }

    describe 'unauthenticated action which references current user' do
      let(:target_action) { 'unauthenticated_with_user_action' }

      it 'returns an response for the current user' do
        make_request

        expect(response.body).to eq "Welcome #{current_user.name}"
      end
    end

    describe 'authenticated action' do
      let(:target_action) { 'authenticated_action' }

      it 'returns a successful response' do
        make_request

        expect(response.status).to eq 200
      end
    end

    describe 'unauthorized action' do
      let(:target_action) { 'unauthorized_action' }

      it 'returns an unauthorized response' do
        make_request

        expect(response.status).to eq 403
        expect(response.body).to match(/You do not have permission to perform that action./)
      end
    end
  end

  context 'when an invalid user token is passed in the header' do
    let(:current_user) { FactoryBot.create(:user) }
    let(:auth_jwt) { 'foobar' }

    describe 'unauthenticated action which references current user' do
      let(:target_action) { 'unauthenticated_with_user_action' }

      it 'returns an unauthenticated response' do
        make_request

        expect(response.status).to eq 401
      end
    end

    describe 'authenticated action' do
      let(:target_action) { 'authenticated_action' }

      it 'returns a successful response' do
        make_request

        expect(response.status).to eq 401
      end
    end
  end
end