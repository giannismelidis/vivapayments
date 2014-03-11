require 'spec_helper'

describe Vivapayments::Configuration do
  
  context 'returns correct api_url' do
    
    example 'default environment is demo' do
      Vivapayments.configuration.api_url.should == "http://demo.vivapayments.com/api/"
      
      config = Vivapayments::Configuration.new
      config.api_url.should == "http://demo.vivapayments.com/api/"
    end
    
    example 'production environment' do
      Vivapayments.configure do |config|
        config.demo = false
      end
      
      Vivapayments.configuration.api_url.should == "https://www.vivapayments.com/api/"
      
      config = Vivapayments::Configuration.new
      config.demo = false
      config.api_url.should == "https://www.vivapayments.com/api/"
    end
    
    example 'demo environment' do
      Vivapayments.configure do |config|
        config.demo = true
      end
      
      Vivapayments.configuration.api_url.should == "http://demo.vivapayments.com/api/"
      
      config = Vivapayments::Configuration.new
      config.demo = true
      config.api_url.should == "http://demo.vivapayments.com/api/"
    end
  end
  
  context 'returns correct redirect_url' do
    example 'demo environment' do
      Vivapayments.configure do |config|
        config.demo = true
      end
      Vivapayments.configuration.redirect_url.should == "http://demo.vivapayments.com/web/checkout"
      
      config = Vivapayments::Configuration.new
      config.redirect_url.should == "http://demo.vivapayments.com/web/checkout"
    end
    
    example 'production environment' do
      Vivapayments.configure do |config|
        config.demo = false
      end
      
      Vivapayments.configuration.redirect_url.should == "https://www.vivapayments.com/web/checkout"
      
      config = Vivapayments::Configuration.new
      config.demo = false
      config.redirect_url.should == "https://www.vivapayments.com/web/checkout"
    end
  end
  
  example 'returns correct api_token' do
    Vivapayments.configuration.api_key.should == "foo"
  end
  
  example 'returns correct merchant_id' do
    Vivapayments.configuration.merchant_id.should == "bar"
  end
end
