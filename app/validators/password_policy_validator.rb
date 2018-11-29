class PasswordPolicyValidator < ActiveModel::Validator
  def validate(record)
    unless record.respond_to?(:password) && record.respond_to?(:password_confirmation)
      raise 'Record must respond to #password and #password_confirmation'
    end

    if record.password != record.password_confirmation
      record.errors.add(:base, :password_confirmation_mismatch)
    end

    length_validator = ActiveModel::Validations::LengthValidator.new(minimum: 8, attributes: %w[password])
    length_validator.validate(record)
  end
end