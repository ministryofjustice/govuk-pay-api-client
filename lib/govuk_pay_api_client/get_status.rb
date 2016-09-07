module GovukPayApiClient
  class GetStatus
    include GovukPayApiClient::Api
    attr_accessor :fee

    def initialize(fee = nil)
      raise RequiresFeeObject if fee.blank?
      @fee = fee
    end

    def call
      get
      parsed_response
    end

    private

    def parsed_response
      OpenStruct.new(
        status: response_body.fetch(:state).fetch(:status)
      )
    end

    def endpoint
      "/payments/#{fee.govpay_payment_id}"
    end
  end
end
