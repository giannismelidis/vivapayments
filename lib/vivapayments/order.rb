module Vivapayments
  class Order
    attr_reader :url, :connection, :id
    attr_accessor :params
    
    def initialize(params={})
      @params     = params
      @connection = Faraday.new(:url => Vivapayments.configuration.api_url)
      connection.basic_auth(Vivapayments.configuration.merchant_id, Vivapayments.configuration.api_key)
      
    end
    
    def id=(value)
      @id = value
    end
    
    def create
      raise ArgumentError, "`Amount` param is required." unless params.keys.map(&:to_sym).include?(:Amount)
      
      valid_params?
      
      content = connection.post("orders", params)
      if content.status == 200 && JSON.parse(content.body)["ErrorCode"] == 0 && JSON.parse(content.body)["OrderCode"]
        @id = JSON.parse(content.body)["OrderCode"]
      else
        raise "Status: #{content.status} - Message: #{content.body}"
      end
    end
    
    def delete
      id_set?
      
      content = connection.delete("orders/#{self.id}") 
      if content.status == 200
        @id = nil
        return content
      else
        raise "#{content.status} : #{JSON.parse(content.body)["Message"]}"
      end
    end
    
    def redirect_url
      id_set?
      [Vivapayments.configuration.redirect_url, "?ref=#{self.id}"].join
    end
    
    protected
    
    def valid_params?
      invalid_params = []
      params.keys.each do |key| 
        invalid_params << key unless accepted_params.include?(key.to_sym)
      end
      
      unless invalid_params.empty?
        raise ArgumentError, "params `#{invalid_params.join(",")}` are not valid. Accepted params: #{accepted_params.map(&:to_s).join(",")}"
      else
        return true
      end
    end
    
    ##
    # To keep compatibility with the API, we use the params format given in
    # the documentation.
    #
    def accepted_params
      [
        :Amount,
        :isPreAuth,
        :ServiceId, 
        :RequestLang, 
        :FullName, 
        :Email, 
        :Phone, 
        :MaxInstallments,
        :MerchantTrns,
        :CustomerTrns,
        :SourceCode,
        :PaymentTimeOut,
        :ExpirationDate,
        :AllowRecurring,
        :Tags,
        :AllowTaxCard,
        :ActionUser,
        :DisableCash,
        :DisableCard
      ]
    end
    
    def id_set?
      raise ArgumentError, "id is not set. Use `create` method or `id=` method." unless self.id
    end
  end
end