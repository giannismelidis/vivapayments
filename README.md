# Vivapayments

Wrapper gem for the Vivapayments API. At the moment it supports creating an
order, deleting an order and getting the redirect URL to complete a
transaction.


## Installation

### As part of a Gemfile in a Ruby application

Add this line to your application's Gemfile:

    gem 'vivapayments'

And then execute:

    $ bundle install
  
### Install the Gem individually

    $ gem install vivapayments

## Usage

Set up config (for example in `initializers/vivapayments.rb`):

    Vivapayments.configure do |config|
      config.merchant_id = "your_merchant_id"
      config.api_key = "your_api_key"
      config.demo = true # true or false
    end

Creating an order:

    order = Vivapayments::Order.new(:Amount => 100)
    order.create

Getting the redirect_url:

    order.redirect_url

Deleting an order (given that you have an id already):

    order.delete

Or if you want to give an existing id:

    order = Vivapayments::Order.new
    order.id = 12345
    order.delete

You can pass all the params that are mentioned in the documentation:
[https://github.com/VivaPayments/API/wiki/Optional-Parameters](https://github.com/VivaPayments/API/wiki/Optional-Parameters)

For more information on the documentation visit:
[https://github.com/VivaPayments/API/wiki](https://github.com/VivaPayments/API/wiki)


## Tests

    MERCHANT_ID=your_merchant_id API_KEY=your_api_key rspec

At the moment it doesn't check the type of the variable for each parameter.
The API silently fails or ignores incorrect parameters, so be sure to check the
 documentation about the correct input.

