README
========

Client gem for [Xrate](https://github.com/GoCoin/xrate) backend service.

This is not for public consumption. When frontend users are granted access to
the exchange service, it should proxied through the MerchantCore API.

```
   [User]
      |
[MerchantCore]
      |
 [xrate-gem]
      |
[Xrate Service]
```

## Installation

Add this line to your application's Gemfile:

    gem 'xrate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xrate


## Usage


```ruby
require 'xrate'

# Configure Xrate
Xrate.url = "http://xrate.gocoin.com"
Xrate.username = "user"
Xrate.password = "password"

# Get exchange rates
rates = Xrate.rates
rates = Xrate.currency_pair(pair, amount, price_depth)
```
```
## example params
# pair: 'BTCUSD'  # (required param)
# amount: 1.0     # fiat amount if request has fiat base_price_currency
                  # crypto amount if base_price_currency is crypto (required param)
# price_depth: true   # optional param - should be set to true if base_price_currency is crypto
```
