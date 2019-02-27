module AuthHeaderHelper
  def jsonapi_headers
    headers = super

    if u = current_user
      credential = Credential.new(user: current_user)
      headers['Authorization'] = "Bearer #{credential.mint_jwt}"
    end

    headers
  end

  # override in tests
  def current_user
  end
end
