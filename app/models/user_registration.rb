class UserRegistration
  include ActiveModel::Model
  include ErrorDelegatable

  attr_accessor :name, :email, :password, :password_confirmation
  attr_reader :user

  validates :name, presence: true
  validates_with PasswordPolicyValidator

  validate :validate_children

  def self.create(attrs)
    new(attrs).tap do |i|
      i.save!
    end
  end

  def initialize(*args)
    super
    password_hash = authenticator.generate_hash(password)
    @user = User.new(
      name: name,
      email: email,
      password_hash: password_hash,
    )
  end

  def save!
    return false unless valid?
    user.save!
  end

  delegate :id, to: :user

  private

  def validate_children
    if user.invalid?
      promote_errors(user.errors)
    end
  end

  def authenticator
    @authenticator ||= Authentication::PasswordAuthenticator.new(pepper: Authentication::PasswordAuthenticator.app_pepper)
  end
end