require 'bcrypt'

module Authentication
  class PasswordAuthenticator
    attr_reader :salt_rounds

    def initialize(pepper: self.class.app_pepper, salt_rounds: 10)
      @pepper = pepper
      @salt_rounds = salt_rounds
    end

    def generate_hash(password)
      BCrypt::Password.create(password_and_pepper(password), :cost => salt_rounds)
    end

    def compare_password(password, hash)
      decoded_hash = BCrypt::Password.new(hash)
      decoded_hash == password_and_pepper(password)
    end

    def password_and_pepper(password)
      return "#{password}#{@pepper}"
    end

    def self.app_pepper
      Rails.application.credentials.authentication[:pepper]
    end
  end
end