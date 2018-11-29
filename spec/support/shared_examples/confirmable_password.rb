RSpec.shared_examples "it has password requirements" do |model|
  let(:record) do
    model.new(password: password, password_confirmation: password_confirmation)
  end

  subject(:validate!) { record.valid? }

  context 'when password and confirmation do not match' do
    let(:password) { 'foo' }
    let(:password_confirmation) { 'bar' }

    it 'adds a validation error' do
      validate!

      expect(record.errors).to be_added(:base, :password_confirmation_mismatch)
    end
  end

  context 'when password and confirmation do match' do
    let(:password_confirmation) { password }

    context 'when password is less than 8 characters' do
      let(:password) { 'foo' }

      it 'adds a validation error' do
        validate!

        expect(record.errors).to be_added(:password, :too_short)
      end
    end

    context 'when password is 8 characters or greater' do
      let(:password) { 'foobarbaz' }

      it 'has no errors' do
        validate!

        expect(record.errors).not_to be_added(:password)
      end
    end
  end
end