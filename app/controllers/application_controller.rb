class ApplicationController < ActionController::API
  include Graphiti::Rails
  include Graphiti::Responders

  register_exception Errors::MissingAuthorizationToken, status: 401, message: true
  register_exception Errors::InvalidAuthorizationToken, status: 401, message: true
  register_exception Errors::NotAuthorized, status: 403, message: true
  register_exception Graphiti::Errors::RecordNotFound, status: 404

  rescue_from Exception do |e|
    handle_exception(e, show_raw_error: Rails.env.test? || Rails.env.development?)
  end

  before_action :authenticate_user!

  def authenticate_user!
    @current_user ||= user_via_jwt
  end

  def current_user
    if defined? @current_user
      @current_user
    else
      authenticate_user!
    end
  rescue Errors::MissingAuthorizationToken
    @current_user = nil
  end

  def user_via_jwt
    invalid_token! unless credential = Credential.load(jwt)
    credential.user
  end

  def jwt
    header = request.headers['Authorization']
    unless header && header.match?(/^Bearer /)
      raise Errors::MissingAuthorizationToken
    end
    header.split(/^Bearer /)[1]
  end

  def invalid_token!
    raise Errors::InvalidAuthorizationToken
  end

  def unauthorized!
    raise Errors::NotAuthorized
  end
end
