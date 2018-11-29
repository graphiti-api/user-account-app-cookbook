require 'rails_helper'

RSpec.describe UserRegistration, type: :model do
  it_behaves_like "it has password requirements", described_class

  describe 'password encryption' do
    it 'assigns the hashed password to the user model' do
      allow_any_instance_of(Authentication::PasswordAuthenticator)
        .to receive(:generate_hash).with('foobar').and_return('encrypt3dF00')

      instance = described_class.new(password: 'foobar', password_confirmation: 'foobar')
      expect(instance.user.password_hash).to eq ('encrypt3dF00')
    end
  end

  describe '#validations' do
    let(:instance) { described_class.new(attrs) }
    subject(:validate!) { instance.valid? }

    let(:attrs) do
      {
        name: "The user's name",
        email: 'first.last@gmail.com',
        password: 'pa$$W0rd!',
        password_confirmation: 'pa$$W0rd!',
      }
    end

    context 'when a user with the provided email already exists' do
      before do
        FactoryBot.create(:user, email: attrs[:email])
      end

      it 'hoists the uniquness error from the user' do
        validate!

        expect(instance.errors).to be_added(:email, :taken)
      end
    end
  end
end
