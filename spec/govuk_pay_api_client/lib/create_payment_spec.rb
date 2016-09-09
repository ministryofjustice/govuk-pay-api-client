require 'rails_helper'
require 'support/shared_examples_for_govpay'

def govpay_payment_id
  'rmpaurrjuehgpvtqg997bt50f'
end

def fee
    Fee.create(
      description: 'Lodgement Fee',
      govpay_reference: '12345',
      amount: 2000,
    )
end

RSpec.describe GovukPayApiClient::CreatePayment do
  include_examples 'govpay payment response', fee, govpay_payment_id

  subject{ described_class.call(fee, 'the_return_url') }

  it 'exposes the next url provided by the api' do
    expect(subject.next_url).
      to eq(
        'https://www-integration-2.pymnt.uk/secure/94b35000-37f2-44e6-a2f5-c0193ca1e98a'
    )
  end

  it 'exposes the payment_id provided by the api' do
    expect(subject.payment_id).to eq('rmpaurrjuehgpvtqg997bt50f')
  end

  it 'requires a fee object' do
    expect {
      described_class.call(nil, 'the_return_url')
    }.to raise_error(GovukPayApiClient::RequiresFeeObject)
  end

  it 'requires a return_url' do
    expect {
      described_class.call(fee, nil)
    }.to raise_error(GovukPayApiClient::RequiresReturnUrl)
  end
end

