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
    # :from (3 letter currency code)
    # :to (3 letter currency code)
    # :amount_in_### (###=3 letter currency code). must be :from XOR :to
    raise ArgumentError.new(':from parameter must be provided') unless params[:from].present?
    raise ArgumentError.new(':to parameter must be provided') unless params[:to].present?

    amount_arg = nil
    if params["amount_in_#{params[:to].downcase}".to_sym].present?
      if params["amount_in_#{params[:from].downcase}".to_sym].present?
        raise ArgumentError.new(":amount_in_#{params[:to].downcase} xor :amount_in_#{params[:from].downcase} must be provided")
      else
        amount_arg = "amount_in_#{params[:to].downcase}=#{params["amount_in_#{params[:to].downcase}".to_sym]}"
      end
    else
      if params["amount_in_#{params[:from].downcase}".to_sym].present?
        amount_arg = "amount_in_#{params[:from].downcase}=#{params["amount_in_#{params[:from].downcase}".to_sym]}"
      else
        raise ArgumentError.new(":amount_in_#{params[:to].downcase} xor :amount_in_#{params[:from].downcase} must be provided")
      end
    end

    response = connection.get("/rates?from=#{params[:from]}&to=#{params[:to]}&#{amount_arg}")
    response.body
  end
end
