module Xrate
  class Request

    def initialize(connection, config)
      @config     = config
      @connection = connection
      validate_config!
    end

    def get(path, options)
      connection.get(path, options)
    end

    def post(path, body)
      send_json_request(:post, path, body)
    end

    def put(path, body)
      send_json_request(:put, path, body)
    end

    def delete(path)
      connection.delete(path)
    end

    private

    def validate_config!
      raise Error, "Xrate configuration missing" unless @config
      raise Error, "Xrate configuration missing url" \
        if @config.url.nil? || @config.url.empty?
      raise Error, "Xrate configuration missing username" \
        if @config.username.nil? || @config.username.empty?
      raise Error, "Xrate configuration missing password" \
        if @config.password.nil? || @config.password.empty?
    end

    def send_json_request(method, path, body)
      connection.send(method, path) do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = body
      end
    end

    attr_reader :connection

  end
end
