module GovukPayApiClient
  class CreatePayment
    include GovukPayApiClient::Api
    attr_accessor :fee, :return_url

    def initialize(fee, return_url)
      raise RequiresFeeObject if fee.blank?
      raise RequiresReturnUrl if return_url.blank?
      @fee = fee
      @return_url = return_url
    end

    def call
      post
      parsed_response
    end

    private

    def endpoint
      '/payments'
    end

    def parsed_response
      OpenStruct.new(
        next_url: response_body.fetch(:_links).fetch(:next_url).fetch(:href),
        payment_id: response_body.fetch(:payment_id)
      )
    end

    def request_body
      {
        return_url: return_url,
        description: fee.description,
        reference: fee.govpay_reference,
        amount: fee.amount
      }
    end
  end
end
