module GraphitiAuthSample
  AUTH_PEPPER = Rails.application.secrets.authentication[:pepper]
  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base
end