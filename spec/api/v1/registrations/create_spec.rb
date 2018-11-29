require 'rails_helper'

RSpec.describe "registrations#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/registrations", payload
  end

  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'registrations',
          attributes: {
            email: 'heisenberg@polloshermanos.com',
            name: 'Walter White',
            password: 'pa$$w0rd',
            password_confirmation: 'pa$$w0rd',
          }
        }
      }
    end

    it 'works' do
      expect(RegistrationResource).to receive(:build).and_call_original

      expect {
        make_request
      }.to change { User.count }.by(1)
    end
  end
end
