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
rates = Xrate.get_spot_rate(params_hash)
```
```
## example params
# from: 'BTC'  # (required param)
# to: 'USD'  # (required param)
# amount_in_usd: 10.0 # given :from and :to above, this would return rate for converting ? BTC into 10.0 USD
# amount_in_btc: 0.1 # given :from and :to above, this would return rate for converting 0.1 BTC into ? USD
# Note that :amount_in_usd XOR :amount_in_btc param must be provided
```
