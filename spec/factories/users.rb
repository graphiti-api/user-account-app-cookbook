FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password_hash do
      auth = Authentication::PasswordAuthenticator.new(salt_rounds: 1)
      auth.generate_hash(password)
    end
    email_verified_at { Time.now }

    transient do
      password { SecureRandom.hex(32) }
    end
  end
end