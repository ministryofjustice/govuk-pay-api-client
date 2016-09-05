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
      govpay_payment_id: govpay_payment_id
    )
end

RSpec.describe GovukPayApiClient::GetStatus do
  include_examples 'govpay payment response', fee, govpay_payment_id

  subject{ described_class.call(fee) }

  it 'requires a fee' do
    expect{ described_class.call }.
      to raise_error(GovukPayApiClient::GetStatus::FeeRequired)
  end

  it 'exposes the received status' do
    expect(subject.status).to eq('success')
  end
end
