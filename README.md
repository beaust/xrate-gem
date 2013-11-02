README
========

Client gem for [Xrate](https://github.com/gc-admin/xrate) backend service.

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
rates = Xrate::Rates.get
