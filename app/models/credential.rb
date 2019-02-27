class Credential
  include ActiveModel::Model

  attr_accessor :user
  attr_accessor :email, :json_web_token

  class << self

    def secret
      Rails.application.credentials.secret_key_base
    end

    def load(jwt)
      begin
        decoded = JWT.decode(jwt, secret, true, { :algorithm => 'HS256' }).first

        if user = User.find(decoded['data']['user_id'])
          new(user: user)
        end
      rescue JWT::ExpiredSignature
      rescue JWT::DecodeError
      end
    end

    def create(attrs)
      new(email: attrs[:email]).tap do |credential|
        if user = User.find_by(email: attrs[:email])
          authenticator = Authentication::PasswordAuthenticator.new

          if authenticator.compare_password(attrs[:password], user.password_hash)
            if user.email_verified_at
              credential.user = user
            else
              credential.errors.add(:base, :email_unverified)
            end
          else
            credential.errors.add(:base, :invalid_credentials)
          end
        else
          credential.errors.add(:base, :invalid_credentials)
        end
      end
    end
  end

  def id
    SecureRandom.uuid
  end

  def user_id
    @user ? user.id : nil
  end

  def mint_jwt!(*args)
    @json_web_token = mint_jwt(*args)
  end

  def mint_jwt(expires_at: 3.days.from_now)
    payload = jwt_payload

    if expires_at.present?
      payload.merge!(exp: expires_at.to_i)
    end

    JWT.encode(payload, self.class.secret)
  end

  def jwt_payload
    {
      data: {
        user_id: user.id,
      }
    }
  end
end