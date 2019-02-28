require 'rails_helper'

RSpec.describe Authentication::EmailActivation do
  let(:user) { FactoryBot.create(:user) }
  let(:instance) { described_class.new(user) }

  before do
    allow(described_class).to receive(:secret).and_return("SuperSekrit")
  end

  describe '#mint_token' do
    it 'mints a base64-encoded jwt with the user information' do
      base64token = instance.mint_token
      token = Base64.urlsafe_decode64(base64token)

      decoded = JWT.decode token, 'SuperSekrit'

      expect(decoded).to eq([
        {
          'data' => {
            'email' => user.email,
            'user_id' => user.id
          }
        },
        { 'alg' => 'HS256' }
      ])
    end
  end

  describe '.load' do
    subject(:load_token) { described_class.load(token) }
    let(:token) do
      Base64.urlsafe_encode64(JWT.encode(payload, 'SuperSekrit'))
    end

    context 'when the token matches a user id and email' do
      let(:user) { FactoryBot.create(:user) }
      let(:payload) do
        {
          data: {
            email: user.email,
            user_id: user.id
          }
        }
      end

      it 'returns an activation with the user' do
        activation = load_token
        expect(activation.user).to eq user
      end
    end

    context 'when the token matches a user id but not the email' do
      let(:user) { FactoryBot.create(:user) }
      let(:user2) { FactoryBot.create(:user) }
      let(:payload) do
        {
          data: {
            email: user2.email,
            user_id: user.id
          }
        }
      end

      it 'returns nil' do
        expect(load_token).to be_nil
      end
    end

    context 'when the token is invalid base64' do
      let(:token) { 'foobarbaz'}

      it 'returns nil' do
        expect(load_token).to be_nil
      end
    end

    context 'when the token is an invalid jwt' do
      let(:token) { Base64.urlsafe_encode64 'foobarbaz' }

      it 'returns nil' do
        expect(load_token).to be_nil
      end
    end
  end
end