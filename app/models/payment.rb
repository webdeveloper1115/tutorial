require 'net/http'
require 'uri'

class Payment < ActiveRecord::Base

  attr_accessor :cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear
    
  attr_accessible :responseMessage, :amount, :amountReceived, :cardNumberMask,
  :cardType, :cardTypeCode, :responseCode, :transactionID, :xref, :cardNumber,
  :cardCVV, :cardExpiryMonth, :cardExpiryYear

  validate :credit_card_api_access, :on => :create
  MERCHANT_ID = "0000992"
  INTEGRATION_URL = "https://gateway.cardstream.com/direct/"

	def request_data
	{ 
	  :amount => self.amount.to_i,
	  :cardNumber => self.cardNumber,
	  :cardExpiryMonth => self.cardExpiryMonth.to_i,
	  :cardExpiryYear => self.cardExpiryYear.to_i,
	  :cardCVV => self.cardCVV.to_i,
	  :merchantID => MERCHANT_ID, 
	  :action => "SALE", 
	  :type => 1,
	  :currencyCode => 826,
	  :orderRef => "Test purchase",
	  :countryCode => 826,
	  :returnInternalData => "Y",
	  :threeDSRequired => "N"
	}
	end
end