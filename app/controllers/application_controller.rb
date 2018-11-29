class ApplicationController < ActionController::API
  include Graphiti::Rails
  include Graphiti::Responders

  register_exception Errors::NotAuthenticated, status: 401
  register_exception Errors::NotAuthorized, status: 403
  register_exception Graphiti::Errors::RecordNotFound, status: 404
  # register_exception ActiveRecord::RecordNotFound, status: 404

  rescue_from Exception do |e|
    handle_exception(e)
  end

  def authenticate_user!
    @current_user ||= user_via_jwt
  end

  def user_via_jwt
    unauthenticated! unless credential = Credential.load(jwt)
    credential.user
  end

  def jwt
    header = request.headers['Authorization']
    unless header && header.match?(/^Bearer /)
      raise Errors::NotAuthenticated, 'No Authorization token provided.'
    end
    header.split(/^Bearer /)[1]
  end

  def unauthenticated!
    raise Errors::NotAuthenticated, 'Access is denied due to invalid token.'
  end
end
