require 'rails_helper'

RSpec.describe RegistrationResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'registrations',
          attributes: user_attrs
        }
      }
    end

    let(:instance) do
      RegistrationResource.build(payload)
    end

    context 'params are valid' do
      let(:user_attrs) do
        {
          name: "The user's name",
          email: 'first.last@gmail.com',
          password: 'pa$$W0rd!',
          password_confirmation: 'pa$$W0rd!',
        }
      end

      it 'persists the user' do
        expect {
          expect(instance.save).to eq(true)
        }.to change { User.count }.by(1)
        expect(User.first.name).to eq(user_attrs[:name])
      end

      it 'enqueues an activation email' do
        expect {
          instance.save
        }.to have_enqueued_job(ActionMailer::DeliveryJob)
          .with("UserMailer", "account_activation", 'deliver_now', anything)
      end
    end
  end
end
