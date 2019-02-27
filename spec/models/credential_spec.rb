require 'rails_helper'

RSpec.describe Credential do
  let(:user) { FactoryBot.create(:user) }

  describe '.load' do
    it 'decodes the user from a minted JWT' do
      cred = Credential.new(user: user)

      jwt = cred.mint_jwt

      expect(Credential.load(jwt).user).to eq user
    end

    context 'when the JWT is expired' do
      before do
        Timecop.freeze
      end

      it 'does not decode the credential' do
        cred = Credential.new(user: user)

        jwt = cred.mint_jwt

        Timecop.travel(Time.now + 4.days)

        expect(Credential.load(jwt)).to be_nil
      end
    end
  end

  describe '.create' do
    subject(:create) { described_class.create(attrs) }
    let(:attrs) do
      {}
    end

    let(:user) { FactoryBot.create(:user, password: 'thepassword') }

    context 'when email does not match any users' do
      before do
        attrs[:email] = "1#{user.email}"
      end

      it 'fails with a validation error' do
        instance = create

        expect(instance.errors).to be_added(:base, :invalid_credentials)
      end
    end

    context 'when email matches a user' do
      before do
        attrs[:email] = user.email
      end

      context 'when the password is incorrect' do
        before do
          attrs[:password] = 'badpassword'
        end

        it 'fails with a validation error' do
          instance = create

          expect(instance.errors).to be_added(:base, :invalid_credentials)
        end

        it 'does not assign the user' do
          instance = create

          expect(instance.user).to be_nil
        end
      end

      context 'when the password is correct' do
        before do
          attrs[:password] = 'thepassword'
        end

        context 'user has not confirmed their email' do
          before do
            user.update_attributes!(email_verified_at: nil)
          end

          it 'has an email verification validation error' do
            instance = create

            expect(instance.errors).to be_added(:base, :email_unverified)
          end
        end

        context 'user has confirmed their email' do
          it 'is valid' do
            instance = create

            expect(instance).to be_valid
          end

          it 'assigns the user' do
            instance = create

            expect(instance.user).to eq user
          end
        end
      end
    end
  end
end