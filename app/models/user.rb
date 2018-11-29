class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  scope :active, ->{ where('email_verified_at IS NOT NULL') }
end
