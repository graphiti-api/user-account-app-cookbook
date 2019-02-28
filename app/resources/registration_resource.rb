class RegistrationResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null
  self.model = UserRegistration

  attribute :name, :string
  attribute :email, :string
  attribute :password, :string, only: :writable
  attribute :password_confirmation, :string, only: :writable

  def create(attributes)
    UserRegistration.create(attributes)
  end

  after_commit only: :create do |registration|
    UserMailer.account_activation(registration.user).deliver_later
  end
end