class CredentialResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null
  self.model = Credential

  attribute :email, :string, only: [:readable, :writable]
  attribute :password, :string, only: :writable
  attribute :json_web_token, :string, only: :readable

  belongs_to :user

  def create(attrs)
    Credential.create(attrs).tap do |c|
      if c.errors.blank?
        c.mint_jwt!
      end
    end
  end
end
