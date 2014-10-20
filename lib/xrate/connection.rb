require 'faraday_middleware'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Xrate
  module Connection
    attr_writer :url, :username, :password, :api_version

    def url
      @url ||= "https://xrate.gocoin.com"
    end

    def username
      @username ||= "admin"
    end

    def password
      @password ||= "password"
    end

    def api_version
      @api_version ||= 2
    end

    def connection
      @api_connection ||= Faraday.new(url: "#{url}/v#{api_version}") do |faraday|
        faraday.request  :basic_auth, username, password
        faraday.request  :json
        faraday.response :json
        faraday.use      ::Xrate::FaradayMiddleware::RaiseHttpException
        #faraday.response :raise_error
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
