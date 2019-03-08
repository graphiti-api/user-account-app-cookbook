module Authentication
  class EmailActivation
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def mint_token
      payload = {
        data: {
          email: user.email,
          user_id: user.id
        }
      }

      Base64.urlsafe_encode64(JWT.encode(payload, self.class.secret))
    end

    def self.load(token)
      begin
        token = Base64.urlsafe_decode64(token)
        decoded = JWT.decode(token, secret, true, { :algorithm => 'HS256' }).first
        data = decoded['data']

        if user = User.find_by(id: data['user_id'], email: data['email'])
          new(user)
        end
      rescue JWT::ExpiredSignature
      rescue JWT::DecodeError
      rescue ArgumentError => e
        unless e.message == 'invalid base64'
          raise e
        end
      end
    end

    def self.secret
      GraphitiAuthSample::SECRET_KEY_BASE
    end
  end
end