require 'govuk_pay_api_client/version'
require 'govuk_pay_api_client/api'
require 'govuk_pay_api_client/create_payment'
require 'govuk_pay_api_client/get_status'

module GovukPayApiClient
  class Unavailable < StandardError; end
  class RequiresFeeObject < StandardError; end
  class RequiresReturnUrl < StandardError; end
end
