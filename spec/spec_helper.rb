$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['GOVUK_PAY_API_URL'] = 'https://govpay-test.dsd.io'
ENV['GOVUK_PAY_API_KEY'] = 'deadbeef'
require 'govuk_pay_api_client'
