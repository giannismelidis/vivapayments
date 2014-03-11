require 'bundler/setup'
require 'rspec'

require_relative '../lib/vivapayments'

Vivapayments.configure do |config|
  config.api_key = "foo"
  config.merchant_id = "bar"
  config.demo = true
end

RSpec.configure do |config|
  config.color = true
end
