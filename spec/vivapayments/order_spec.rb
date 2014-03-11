require 'spec_helper'

describe Vivapayments::Order do
  
  context "set ENV['MERCHANT_ID'] and ENV['API_KEY'] for tests" do
    before :all do
      Vivapayments.configure do |config|
        config.api_key = ENV['API_KEY']
        config.merchant_id = ENV['MERCHANT_ID']
        config.demo = true
      end
    end
  
    example 'raise ArgumentError if `Amount` param is missing' do
      order = Vivapayments::Order.new
      expect{ order.create}.to raise_error(ArgumentError, "`Amount` param is required.")
    end
  
    example 'raise ArgumentError if invalid param is given' do
      order = Vivapayments::Order.new(:Amount => 100, :foo => "bar")
      expect{ order.create}.to raise_error(ArgumentError)
    end
  
    example 'set id correctly' do
      order = Vivapayments::Order.new
      order.id = 101
      order.id.should == 101
    end
    
    example 'get id from create' do
      order = Vivapayments::Order.new(:Amount => 100)
      order.create
      order.id.is_a?(Fixnum).should == true
    end
    
    example 'raise ArgumentError if id is not set on delete' do
      order = Vivapayments::Order.new
      expect{ order.delete}.to raise_error(ArgumentError, "id is not set. Use `create` method or `id=` method.")
    end
    
    example 'return nil id after delete' do
      order = Vivapayments::Order.new(:Amount => 100)
      order.create
      order.delete
      order.id.should == nil
    end
    
    example 'return status 200 on successful delete' do
      order = Vivapayments::Order.new(:Amount => 100)
      order.create
      res = order.delete
      res.status.should == 200
    end
    
    example 'return correct redirect_url' do
      order = Vivapayments::Order.new(:Amount => 100)
      order.create
      order.redirect_url.should == "http://demo.vivapayments.com/web/checkout?ref=#{order.id}"
    end
  end
end
