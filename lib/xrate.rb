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

  def self.currency_pair(pair)
    begin
      response = connection.get "/rates?currency_pair=#{pair}"
      response.body
    rescue
      { 'timestamp' => Time.now.utc, 'currency_pair' => pair, 'rates' => { pair.to_s => nil } }
    end
  end
end
# Xrate.currency_pair('BTCUSD')
