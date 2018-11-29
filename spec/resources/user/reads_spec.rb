require 'rails_helper'

RSpec.describe UserResource, type: :resource do
  describe 'serialization' do
    let!(:user) { FactoryBot.create(:user) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(user.id)
      expect(data.jsonapi_type).to eq('users')
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
