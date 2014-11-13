$:.unshift File.dirname(__FILE__)

require "xrate/version"
require "xrate/error"

# XRate
# Provides an interface to the GoCoin Xrate backend web service.
# Xrate is not a public facing web service and is intended only for internal
# consumption by GoCoin applications.
#
# @example
#
#     require 'xrate'
#     Xrate.url = "http://xrate.gocoin.com"
#     Xrate.username = "user"
#     Xrate.password = "password"
#     rates = Xrate::Rates.get
#
module Xrate
  autoload :Config,     'xrate/config'
  autoload :Connection, 'xrate/connection'
  autoload :Request,    'xrate/request'

  extend Connection

  # Can only be called before the connection to make a request.
  def self.enable_faraday_logger
    connection.response :logger
  end

  def self.config
    @_config ||= Config.new
  end

  # Performs a request to get exchange rates from the GoCoin Xrate backend
  # service. This is not a public facing web service, and is intended to be
  # consumed internally by GoCoin applications.
  #
  def self.rates(base="USD")
    response = connection.get "/rates?base=#{base}"
    response.body
  end

  def self.get_spot_rate(params)
    raise ArgumentError.new('arguments must be a single key-value pair :from => :to') unless params.class == Hash && params.length == 1

    from = params.first[0]
    to = params.first[1]

    response = connection.get("/rates?from=#{from}&to=#{to}")

    raise "Invalid Xrate response: :timestamp cannot be nil" if response.body['timestamp'].nil?
    raise "Invalid Xrate response: :from is (#{response.body['from']}) but was expecting (#{from})" if response.body['from'] != from
    raise "Invalid Xrate response: :to is (#{response.body['to']}) but was expecting (#{to})" if response.body['to'] != to
    raise "Invalid Xrate response: :spot_rate cannot be nil" if response.body['spot_rate'].nil?

    response.body['spot_rate']
  end
end
