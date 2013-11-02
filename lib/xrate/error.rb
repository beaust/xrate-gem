module Xrate
  class Error < StandardError
  end

  # 400 Bad Request
  class BadRequest < Error
  end

  # 401 Unauthorized
  class UnauthorizedAccess < Error
  end

  # 403 Forbidden
  class ForbiddenAccess < Error
  end

  # 404 Not Found
  class NotFound < Error
  end

  # 409 Conflict
  class ResourceConflict < Error
  end

  # 410 Gone
  class ResourceGone < Error
  end

  # 422 Unprocessable Entity
  class UnprocessableEntity < Error
  end

  # 500 Server Error
  class InternalServerError < Error
  end

  # 503 Server Error
  class ServiceUnavailable < Error
  end
end
