class FeesController < ApplicationController
  def pay
    fee = Fee.find(params[:id])

    @payment = GovukPayApiClient::CreatePayment.
      call(fee, 'the_return_url').tap { |p|
        fee.update(govpay_payment_id: p.govpay_id)
    }
  rescue GovukPayApiClient::Unavailable
    @govuk_pay_unavailable = 'The service is currently unavailable'
  end

  def post_pay
    @fee = Fee.find(params[:id])

    @payment = GovukPayApiClient::GetStatus.call(@fee).tap { |gp|
      fee.update(govpay_payment_status: gp.status,
                 govpay_payment_message: gp.message)
    }
  rescue GovukPayApiClient::Unavailable
    @govuk_pay_unavailable = 'We couldn’t find your payment details'
  end
end
