require "spec_helper"

describe Faraday::Response do
  # Create a Faraday stub
  before do
    @conn = Faraday.new do |builder|
      builder.response :json
      builder.use      ::Xrate::FaradayMiddleware::RaiseHttpException
      builder.adapter :test do |stubs|
        stubs.get("/success") { [200, {}, nil] }
        stubs.get("/bad-request") { [400, {}, nil] }
        stubs.get("/unauthorized-access") { [401, {}, nil] }
        stubs.get("/forbidden-access") { [403, {}, nil] }
        stubs.get("/not-found") { [404, {}, nil] }
        stubs.get("/unprocessable-entity") { [422, {}, nil] }
        stubs.get("/internal-server-error") { [500, {}, nil] }
        stubs.get("/service-unavailable") { [503, {}, nil] }
      end
    end
  end

  {
    'bad-request' => Xrate::BadRequest,
    'unauthorized-access' => Xrate::UnauthorizedAccess,
    'forbidden-access' => Xrate::ForbiddenAccess,
    'not-found' => Xrate::NotFound,
    'unprocessable-entity' => Xrate::UnprocessableEntity,
    'internal-server-error' => Xrate::InternalServerError,
    'service-unavailable' => Xrate::ServiceUnavailable
  }.each do |status, exception|
    describe "when request is /#{status}" do

      it "should raise #{exception.name} error" do
        lambda do
          @conn.get("/#{status}")
        end.should raise_error(exception)
      end

    end
  end

end
