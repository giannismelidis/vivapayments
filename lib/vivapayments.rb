require 'faraday'
require 'json'

require_relative "vivapayments/version"
require_relative "vivapayments/configuration"
require_relative "vivapayments/order"

module Vivapayments
  attr_reader :configuration

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end