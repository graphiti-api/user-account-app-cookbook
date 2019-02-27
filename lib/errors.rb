module Errors
  class NotAuthenticated < StandardError
  end

  class MissingAuthorizationToken < Errors::NotAuthenticated
    def message
      'No Authorization token provided.'
    end
  end

  class InvalidAuthorizationToken < Errors::NotAuthenticated
    def message
      'Access is denied due to invalid token.'
    end
  end

  class NotAuthorized < StandardError
    def message
      'You do not have permission to perform that action.'
    end
  end
end