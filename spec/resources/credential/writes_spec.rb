require 'rails_helper'

RSpec.describe CredentialResource, type: :resource do
  describe 'creating' do
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

    let(:user) { FactoryBot.create(:user, password: 'pa$$w0rd') }

    let(:instance) do
      CredentialResource.build(payload)
    end

    context 'password is correct' do
      it 'validates' do
        expect(instance.save).to eq(true)
      end

      it 'assigns the jwt' do
        instance.save

        expect(instance.data.json_web_token).to be_present
      end
    end

    context 'password is incorrect' do
      before do
        payload[:data][:attributes][:password] = 'bad'
      end

      it 'is invalid' do
        expect(instance.save).to eq(false)

        expect(instance.data.errors).to be_added(:base, :invalid_credentials)
      end

      it 'does not assign the jwt' do
        instance.save

        expect(instance.data.json_web_token).to be_blank
      end
    end
  end
end
