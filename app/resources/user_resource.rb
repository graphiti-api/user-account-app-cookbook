class UserResource < ApplicationResource
  attribute :email, :string
  attribute :name, :string
  attribute :avatar_url, :string do
    hash = Digest::MD5.hexdigest(@object.email)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end
