module Vivapayments
  class Configuration
    attr_accessor :api_key, :merchant_id, :demo
    attr_reader :url, :api_url, :redirect_url
    
    def initialize
      @demo = true
    end
    
    def url
      @url = demo ? "http://demo.vivapayments.com/" : "https://www.vivapayments.com/"
    end
    
    def api_url
      @api_url = [url, "api/"].join
    end
    
    def redirect_url
      @redirect_url = [url, "web/checkout"].join
    end
  end
end
