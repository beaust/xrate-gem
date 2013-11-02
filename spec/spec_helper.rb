require 'simplecov'
SimpleCov.start  do
  load_adapter 'test_frameworks'
  add_group 'Xrate', 'lib/xrate'
  add_group 'Faraday Middleware', 'lib/faraday'
end

Dir[File.expand_path('../../lib/*.rb', __FILE__)].each{|f| require f}
require 'rspec'
