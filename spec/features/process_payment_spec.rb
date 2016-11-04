require 'rails_helper'
require 'support/shared_examples_for_govpay'

def govpay_payment_id
  'rmpaurrjuehgpvtqg997bt50f'
end

def fee
  Fee.create(
    description: 'Lodgement Fee',
    govpay_reference: '12345',
    amount: 2000
  )
end

def paid_fee
  Fee.create(
    description: 'Lodgement Fee',
    govpay_reference: '12345',
    amount: 2000,
    govpay_payment_id: govpay_payment_id
  )
end

RSpec.feature 'process payment' do
  describe '#pay (create_payment)' do
    include_examples 'govpay payment response', fee, govpay_payment_id

    context 'Govuk pay responds as expected' do
      it '"redirects" to govpay payment URL' do
        visit "/fees/#{fee.id}/pay"
        expect(page).to have_text(
          'https://www-integration-2.pymnt.uk/secure/94b35000-37f2-44e6-a2f5-c0193ca1e98a'
        )
      end
    end

    context 'Govuk pay returns a 404' do
      include_examples 'govpay returns a 404', fee

      it 'alerts the user the service is unavailable' do
        visit "/fees/#{fee.id}/pay"
        expect(page).to have_text('The service is currently unavailable')
      end
    end

    context 'Govuk pay times out' do
      include_examples 'govpay create payment times out'

      it 'alerts the user the service is unavailable' do
        visit "/fees/#{fee.id}/pay"
        expect(page).to have_text('The service is currently unavailable')
      end
    end
  end

  describe '#post_pay (get_status)' do
    context 'a successful payment' do
      include_examples 'govpay payment response', paid_fee, govpay_payment_id
      it 'notifies the user that their payment was taken' do
        visit "/fees/#{paid_fee.id}/post_pay"
        expect(page).to have_text(paid_fee.case_reference)
        expect(page).to have_text(paid_fee.case_title)
        expect(page).to have_text(paid_fee.govpay_payment_id)
      end
    end

    context 'govuk get_status returns a 500' do
      let(:docpath) { '/v1' }
      include_examples 'govpay post_pay returns a 500', govpay_payment_id

      it 'alerts the user to the failure' do
        visit "/fees/#{paid_fee.id}/post_pay"
        expect(page).to have_text('We couldn’t find your payment details')
      end
    end

    context 'govuk get_status times out' do
      include_examples 'govpay payment status times out', govpay_payment_id

      it 'alerts the user to the failure' do
        visit "/fees/#{paid_fee.id}/post_pay"
        expect(page).to have_text('We couldn’t find your payment details')
      end
    end
  end
end
