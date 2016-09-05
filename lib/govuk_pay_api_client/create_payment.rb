module GovukPayApiClient
  class CreatePayment
    include GovukPayApiClient::Api

    def initialize(fee, return_url)
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
        response_body.merge(
          next_url: response_body.fetch(:_links).fetch(:next_url).fetch(:href)
        )
      )
    end

    def request_body
      {
        return_url: @return_url,
        description: @fee.description,
        reference: @fee.govpay_reference,
        amount: @fee.amount
      }
    end
  end
end
