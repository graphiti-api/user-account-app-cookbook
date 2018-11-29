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
end