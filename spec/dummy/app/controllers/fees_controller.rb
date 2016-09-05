class FeesController < ApplicationController
  def pay
    fee = Fee.find(params[:id])

    @payment = GovukPayApiClient.create_payment(fee).tap { |p|
      fee.update(govpay_payment_id: p.govpay_id)
    }
  end

  def post_pay
    @fee = Fee.find(params[:id])

    @payment = GovukPayApiClient.get_payment(@fee).tap { |gp|
      fee.update(govpay_payment_status: gp.status,
                 govpay_payment_message: gp.message)
    }
  end
end
