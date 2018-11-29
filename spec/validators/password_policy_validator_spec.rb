require 'rails_helper'

model_class = Class.new do
  include ActiveModel::Model
  attr_reader :password, :password_confirmation

  validates_with PasswordPolicyValidator

  def self.name
    'TestModel'
  end

  def initialize(password:, password_confirmation:)
    @password, @password_confirmation = password, password_confirmation
  end
end

RSpec.describe PasswordPolicyValidator do
  it_behaves_like "it has password requirements", model_class
end